{
  description = "Piece of English website";

  outputs = inputs @ {self, flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      flake.nixosModules.default = import ./nix/module.nix {inherit self;};

      perSystem = {system, ...}: let
        pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [(import ./nix/overlay.nix)];
        };
      in {
        packages.default = pkgs.callPackage ./nix/package.nix {};
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
