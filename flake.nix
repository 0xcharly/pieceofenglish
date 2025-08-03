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
        overlay = prev: final: rec {
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

        mixNixDeps = import ./deps.nix {inherit (pkgs) lib beamPackages;};

        installHook = {release}: ''
          export APP_VERSION="${version}"
          export APP_NAME="${pname}"
          export ELIXIR_RELEASE="1.18"
          runHook preInstall
          mix release --no-deps-check --path "$out" ${release}
          runHook postInstall
        '';
        meta = with pkgs.lib; {
          license = licenses.mit;
          homepage = "https://pieceofenglish.fr";
          description = "The frontend and backend implementation of pieceofenglish.fr";
        };

        release = pkgs.beamPackages.mixRelease {
          inherit pname version src mixNixDeps meta;
          mixEnv = "prod";
          installPhase = installHook {release = "prod";};
        };
        debug = pkgs.beamPackages.mixRelease {
          inherit pname version src mixNixDeps meta;
          mixEnv = "dev";
          installPhase = installHook {release = "dev";};
        };
      in {
        packages = {
          default = release;
          inherit release debug;
        };
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
