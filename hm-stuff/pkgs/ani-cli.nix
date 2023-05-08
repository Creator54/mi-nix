{ pkgs, lib, ... }:

let
  ani-cli = pkgs.ani-cli.overrideAttrs (old: {
    src = (pkgs.fetchFromGitHub {
      owner = "pystardust";
      repo = "ani-cli";
      rev = "master";
      sha256 = "sha256-5wKaLaeMHcbNOgFzSCpLPmA4Zh3MzB5Oou/bcB0f8rQ=";
    });
  });
in
{
  home.packages = [ ani-cli ];
}
