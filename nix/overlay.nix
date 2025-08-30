prev: _final: rec {
  beamPackages = prev.beam.packagesWith prev.beam.interpreters.erlang_27;
  elixir = beamPackages.elixir_1_18;
  erlang = prev.erlang_27;
  hex = beamPackages.hex;
  final.mix2nix = prev.mix2nix.overrideAttrs {
    nativeBuildInputs = [final.elixir];
    buildInputs = [final.erlang];
  };
}
