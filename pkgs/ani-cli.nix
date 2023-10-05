{ pkgs, lib, ... }:

let
  ani-cli = pkgs.ani-cli.overrideAttrs (old: {
    src = (pkgs.fetchFromGitHub {
      owner = "pystardust";
      repo = "ani-cli";
      rev = "master";
      sha256 = "sha256-gWHxBo9KZs8HeVLftzZwUgDC2fZK4zfQLblFrPsaOho=";
    });
  });
in
{
  home.packages = [ ani-cli ];
}
