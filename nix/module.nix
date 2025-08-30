{self}: {
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.pieceofenglish;
in {
  options.services.pieceofenglish = {
    enable = lib.mkEnableOption "Piece of English";

    package = lib.mkPackageOption pkgs "pieceofenglish" {
      inherit (self.packages.${pkgs.system}) default;
    };

    autoStart = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to start teslamate on boot.";
    };

    user = lib.mkOption {
      description = "Unix User to run the server under";
      type = lib.types.str;
      default = "taskchampion";
    };

    group = lib.mkOption {
      description = "Unix Group to run the server under";
      type = lib.types.str;
      default = "taskchampion";
    };

    environmentFile = lib.mkOption {
      type = lib.types.path;
      example = "/run/secrets/pieceofenglish.env";
      description = lib.mdDoc ''
        Path to an env file containing the secrets used by the Piece of English service.

        See https://hexdocs.pm/phoenix/Phoenix.Endpoint.html#module-runtime-configuration.

        Must contain at least:
        - `SECRET_KEY_BASE`: secret key used as a base to generate secrets for encrypting and signing data.
      '';
    };

    dataDir = lib.mkOption {
      type = lib.types.path;
      description = "Directory in which to store data";
      default = "/var/lib/pieceofenglish";
    };

    listenAddress = lib.mkOption {
      type = lib.types.str;
      default = "127.0.0.1";
      example = "0.0.0.0";
      description = "Host address on which to serve";
    };

    port = lib.mkOption {
      type = lib.types.port;
      default = 20259;
      description = "Port on which to serve";
    };

    baseUrl = lib.mkOption {
      type = lib.types.str;
      default = "pieceofenglish.fr";
      description = "Base path of the service url.";
    };

    openFirewall = lib.mkEnableOption "Open firewall port for Piece of English";
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.user} = {
      isSystemUser = true;
      inherit (cfg) group;
    };
    users.groups.${cfg.group} = {};

    networking.firewall.allowedTCPPorts = lib.mkIf (cfg.openFirewall) [cfg.port];

    systemd = {
      tmpfiles.settings."10-pieceofenglish"."${cfg.dataDir}".d = {
        inherit (cfg) group user;
        mode = "0750";
      };

      services.pieceofenglish = {
        description = "Piece of English";
        wantedBy = lib.mkIf cfg.autoStart ["multi-user.target"];
        after = ["network.target"];
        serviceConfig = {
          User = cfg.user;
          Group = cfg.group;
          DynamicUser = false;

          ExecStartPre = ''${lib.getExe cfg.package} eval "Poe.Release.migrate"'';
          ExecStart = ''${lib.getExe cfg.package} start'';
          ExecStop = ''${lib.getExe cfg.package} stop'';

          WorkingDirectory = cfg.dataDir;
          EnvironmentFile = cfg.environmentFile;
        };
        environment =
          {
            DATABASE_PATH = "${cfg.dataDir}/pieceofenglish.sqlite3";
            HTTP_BINDING_ADDRESS = cfg.listenAddress;
            PHX_SERVER = toString true;
            PORT = toString cfg.port;
          }
          // lib.optionalAttrs (cfg.baseUrl != null) {PHX_HOST = cfg.baseUrl;};
      };
    };
  };
}
