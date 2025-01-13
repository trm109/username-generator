{ pkgs, lib, config, inputs, ... }:
let stable = import inputs.nixpkgs-stable { system = pkgs.stdenv.system; };
in {
  # https://devenv.sh/basics/
  env.GREET = "devenv";

  # https://devenv.sh/packages/
  packages = [
    pkgs.git
    pkgs.espeak
    pkgs.alsa-utils
    pkgs.nix-index
    pkgs.piper-tts
    pkgs.pv
    pkgs.sox
    pkgs.bc
  ];

  # https://devenv.sh/languages/
  # languages.rust.enable = true;
  languages.python.enable = true;
  languages.python.uv.enable = true;

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
    export LD_LIBRARY_PATH=${pkgs.glib}/lib
  '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "No tests implemented"
  '';

  git-hooks.hooks = {
    # For bash scripts
    shellcheck.enable = true;
    # For Python scripts
    black.enable = true;
  };
  # See full reference at https://devenv.sh/reference/options/
}
