{ pkgs, lib, ... }:

let
  ani-cli = pkgs.ani-cli.overrideAttrs (old: {
    src = (pkgs.fetchFromGitHub {
      owner = "pystardust";
      repo = "ani-cli";
      rev = "master";
      sha256 = "sha256-P464tpIDCYkwKMbrdcFIQ1syc2hrtJbl69kVwNWRT4w=";
    });
  });
in
{
  home.packages = [ ani-cli ];
}
