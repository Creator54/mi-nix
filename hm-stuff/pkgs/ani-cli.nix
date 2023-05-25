{ pkgs, lib, ... }:

let
  ani-cli = pkgs.ani-cli.overrideAttrs (old: {
    src = (pkgs.fetchFromGitHub {
      owner = "pystardust";
      repo = "ani-cli";
      rev = "master";
      sha256 = "sha256-vxGQnu/YudC/Jla5lpos6fZwUpb5eaHCC2e87xJ0SPY=";
    });
  });
in
{
  home.packages = [ ani-cli ];
}
