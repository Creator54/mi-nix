{ config, pkgs, lib, ... }:
let
  link = config.lib.file.mkOutOfStoreSymlink;

  livewallLocal = /home/${(import ../../userConfig.nix).user}/livewall/livewall;
  livewallSrc = if builtins.pathExists livewallLocal then link livewallLocal else link builtins.fetchurl{
    url = "https://raw.githubusercontent.com/Creator54/livewall/main/livewall";
    sha256 = "sha256:1v7jv0h04b6zq07lgl58gpmhlqx7j6k2rljddiw99hazkp0fl50l";
  };

  c = pkgs.writeShellScriptBin "c" ''${link ./c.sh} "$@"'';
  v = pkgs.writeShellScriptBin "v" ''${link ./v.sh} "$@"'';
  gr = pkgs.writeShellScriptBin "gr" ''${link ./gr.sh} "$@"'';
  net = pkgs.writeShellScriptBin "net" ''${link ./net.sh} "$@"'';
  livewall = pkgs.writeShellScriptBin "livewall" ''${livewallSrc} "$@"'';
  ram = pkgs.writeShellScriptBin "ram" ''${link ./ram.sh}'';
  cpu = pkgs.writeShellScriptBin "cpu" ''${link ./cpu.sh}'';
  fgit = pkgs.writeShellScriptBin "fgit" ''${link ./fgit.sh} "$@"'';
  audio = pkgs.writeShellScriptBin "audio" ''${link ./audio.sh} "$@"'';
  battery = pkgs.writeShellScriptBin "battery" ''${link ./battery.sh} "$@"'';
  packages = pkgs.writeShellScriptBin "packages" ''${link ./packages.sh}'';
  wifiInterface = pkgs.writeShellScriptBin "wifiInterface" ''ip a | grep wlp | cut -d':' -f2| head -n1 |xargs'';
in
{
  home.packages = with pkgs; [
    c v gr net ram cpu fgit audio livewall battery packages wifiInterface
  ];
}

