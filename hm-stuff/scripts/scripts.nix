{ config, pkgs, lib, ... }:
let
  link = config.lib.file.mkOutOfStoreSymlink;
  c = pkgs.writeShellScriptBin "c" ''${link ./c.sh} $@'';
  gr = pkgs.writeShellScriptBin "gr" ''${link ./gr.sh} $@'';
  net = pkgs.writeShellScriptBin "net" ''${link ./net.sh} $@'';
  ram = pkgs.writeShellScriptBin "ram" ''${link ./ram.sh}'';
  cpu = pkgs.writeShellScriptBin "cpu" ''${link ./cpu.sh}'';
  fgit = pkgs.writeShellScriptBin "fgit" ''${link ./fgit.sh} $@'';
  audio = pkgs.writeShellScriptBin "audio" ''${link ./audio.sh} $@'';
  battery = pkgs.writeShellScriptBin "battery" ''${link ./battery.sh} $@'';
  packages = pkgs.writeShellScriptBin "packages" ''${link ./packages.sh}'';
  wifiInterface = pkgs.writeShellScriptBin "wifiInterface" ''ip a | grep wlp | cut -d':' -f2| head -n1 |xargs'';
in
{
  home.packages = with pkgs; [
    c gr net ram cpu fgit audio battery packages wifiInterface
  ];
}

