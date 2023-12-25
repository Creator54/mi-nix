{ config, pkgs, ... }:
let
  link = config.lib.file.mkOutOfStoreSymlink;

  livewall = pkgs.writeShellScriptBin "livewall" (builtins.readFile (builtins.fetchurl {
    url = "https://raw.githubusercontent.com/Creator54/livewall/main/livewall";
    sha256 = builtins.hashFile "sha256" (builtins.fetchurl {
      url = "https://raw.githubusercontent.com/Creator54/livewall/main/livewall";
    });
  }));

  ghv = pkgs.writeShellScriptBin "ghv" (builtins.readFile (builtins.fetchurl {
    url = "https://raw.githubusercontent.com/Creator54/ghv/main/ghv";
    sha256 = builtins.hashFile "sha256" (builtins.fetchurl {
      url = "https://raw.githubusercontent.com/Creator54/ghv/main/ghv";
    });
  }));

  c = pkgs.writeShellScriptBin "c" ''${link ./c.sh} "$@"'';
  v = pkgs.writeShellScriptBin "v" ''${link ./v.sh} "$@"'';
  gr = pkgs.writeShellScriptBin "gr" ''${link ./gr.sh} "$@"'';
  bt = pkgs.writeShellScriptBin "bt" ''${link ./bt.sh}'';
  net = pkgs.writeShellScriptBin "net" ''${link ./net.sh} "$@"'';
  ram = pkgs.writeShellScriptBin "ram" ''${link ./ram.sh}'';
  cpu = pkgs.writeShellScriptBin "cpu" ''${link ./cpu.sh}'';
  fgit = pkgs.writeShellScriptBin "fgit" ''${link ./fgit.sh} "$@"'';
  swap = pkgs.writeShellScriptBin "swap" ''${link ./swap.sh} "$@"'';
  cdev = pkgs.writeShellScriptBin "cdev" ''${link ./cdev.sh} "$@"'';
  audio = pkgs.writeShellScriptBin "audio" ''${link ./audio.sh} "$@"'';
  maxzip = pkgs.writeShellScriptBin "maxzip" ''${link ./maxzip.sh} "$@"'';
  battery = pkgs.writeShellScriptBin "battery" ''${link ./battery.sh} "$@"'';
  wificonnect = pkgs.writeShellScriptBin "wificonnect" ''${link ./wificonnect.sh} "$@"'';
  packages = pkgs.writeShellScriptBin "packages" ''${link ./packages.sh}'';
  wifiInterface = pkgs.writeShellScriptBin "wifiInterface" ''ip a | grep wlp | cut -d':' -f2| head -n1 |xargs'';
in
{
  home.packages = [
    c v bt gr ghv net ram cpu cdev fgit swap maxzip audio battery packages wificonnect livewall wifiInterface
  ];
}

