{
  pkgs,
  lib,
  inputs,
  ...
}: {
  # https://devenv.sh/packages/
  packages = with pkgs; [
    alejandra
    just

    inotify-tools
    next-ls
  ];

  languages = {
    elixir.enable = true;
    nix = {
      enable = true;
      lsp.package = pkgs.nixd;
    };
  };

  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo hello from $GREET
  '';

  enterShell = ''
    hello
    git --version
  '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # https://devenv.sh/git-hooks/
  # git-hooks.hooks.shellcheck.enable = true;

  scripts.fmt.exec = let
    fmt-opts = {
      projectRootFile = "mix.lock";
      programs = {
        alejandra.enable = true;
        deadnix.enable = true;
        mix-format.enable = true;
        prettier.enable = true;
        shfmt.enable = false;
        stylua.enable = true;
        taplo.enable = true;
      };
    };
    fmt = inputs.treefmt-nix.lib.mkWrapper pkgs fmt-opts;
  in
    lib.getExe fmt;
  # See full reference at https://devenv.sh/reference/options/
}
