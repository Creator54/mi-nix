{ pkgs, lib, ... }:

let
  ani-cli = pkgs.ani-cli.overrideAttrs (old: {
    src = (pkgs.fetchFromGitHub {
      owner = "pystardust";
      repo = "ani-cli";
      rev = "master";
      sha256 = "sha256-8fpOCyv/XafrVy76jtazRoHW2gidjikgnRdaWzh8kY8=";
    });
  });
in
{
  home.packages = [ ani-cli ];
}
