{ pkgs, lib, ... }:

let
  ani-cli = pkgs.ani-cli.overrideAttrs (old: {
    src = (pkgs.fetchFromGitHub {
      owner = "pystardust";
      repo = "ani-cli";
      rev = "master";
      sha256 = "sha256-udNg2yWigUIM4ACqnBtl6VKHk6iapq0EZukjo7qOloI=";
    });
  });
in
{
  home.packages = [ ani-cli ];
}
