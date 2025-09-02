{
  beamPackages,
  lib,
}: let
  pname = "piece-of-english";
  version = "0.0.1-dev";
  src = ./..;

  mixNixDeps = import ./deps.nix {
    inherit beamPackages lib;

    # https://kivikakk.ee/2025/07/31/using-phoenix-liveview-1.1-with-nix
    # https://github.com/Makesesama/uknown/blob/96a89d1ca87c94619ab4966b798d33d923be715c/nix/deps.nix
    # Works around the following error:
    # > ** (File.Error) could not make directory (with -p) "/homeless-shelter/.cache/elixir_make": no such file or directory
    overrides = _final: prev: {
      exqlite = prev.exqlite.overrideAttrs (_prevAttrs: {
        preConfigure = ''
          export ELIXIR_MAKE_CACHE_DIR="$TMPDIR/.cache"
        '';
      });
    };
  };

  meta = with lib; {
    license = licenses.mit;
    homepage = "https://pieceofenglish.fr";
    description = "The frontend and backend implementation of pieceofenglish.fr";
    mainProgram = "poe";
  };
in
  beamPackages.mixRelease {
    inherit pname version src mixNixDeps meta;
    removeCookie = false;

    preInstall = ''
      # Skip deps checking when running external tasks.
      # https://github.com/phoenixframework/phoenix/issues/2690
      mix do deps.loadpaths --no-deps-check, phx.digest
    '';
  }
