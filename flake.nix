{
  description = "Piece of English website";

  outputs = inputs @ {
    flake-parts,
    nixpkgs,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      perSystem = {system, ...}: let
        overlay = prev: _final: rec {
          beamPackages = prev.beam.packagesWith prev.beam.interpreters.erlang_27;
          elixir = beamPackages.elixir_1_18;
          erlang = prev.erlang_27;
          hex = beamPackages.hex;
          final.mix2nix = prev.mix2nix.overrideAttrs {
            nativeBuildInputs = [final.elixir];
            buildInputs = [final.erlang];
          };
        };

        pkgs = import nixpkgs {
          inherit system;
          overlays = [overlay];
        };

        pname = "piece-of-english";
        version = "0.0.1-dev";
        src = ./.;

        mixNixDeps = import ./deps.nix {
          inherit (pkgs) lib beamPackages;

          # https://kivikakk.ee/2025/07/31/using-phoenix-liveview-1.1-with-nix
          # https://github.com/Makesesama/uknown/blob/96a89d1ca87c94619ab4966b798d33d923be715c/nix/deps.nix
          # Works around the following error:
          # > ** (File.Error) could not make directory (with -p) "/homeless-shelter/.cache/elixir_make": no such file or directory
          overrides = final: prev: {
            exqlite = prev.exqlite.overrideAttrs (prevAttrs: {
              preConfigure = ''
                export ELIXIR_MAKE_CACHE_DIR="$TMPDIR/.cache"
              '';
            });
          };
        };

        meta = with pkgs.lib; {
          license = licenses.mit;
          homepage = "https://pieceofenglish.fr";
          description = "The frontend and backend implementation of pieceofenglish.fr";
        };

        release = pkgs.beamPackages.mixRelease {
          inherit pname version src mixNixDeps meta;
          removeCookie = false;
          # mixEnv = "prod";
          # installPhase = installHook {release = "prod";};

          # Deploy assets before creating release
          # preInstall = ''
          #   # https://github.com/phoenixframework/phoenix/issues/2690
          #   mix do deps.loadpaths --no-deps-check, assets.deploy
          #   mix phx.digest
          # '';
        };
      in {
        packages.default = release;
      };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };
}
