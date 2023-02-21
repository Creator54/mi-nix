{ pkgs, lib, ... }:

let
  ani-cli = pkgs.ani-cli.overrideAttrs (old: {
    src = (builtins.fetchTarball {
      url = "https://github.com/pystardust/ani-cli/archive/master.tar.gz";
    });
  });
in
{
  home.packages = [ ani-cli ];
}
