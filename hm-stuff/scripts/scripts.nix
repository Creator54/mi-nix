{ config, pkgs, lib, ... }:
let
  link = config.lib.file.mkOutOfStoreSymlink;
  c = pkgs.writeShellScriptBin "c" ''${link ./c.sh} $@'';
  net = pkgs.writeShellScriptBin "net" ''${link ./net.sh} $@'';
  ram = pkgs.writeShellScriptBin "ram" ''${link ./ram.sh}'';
  cpu = pkgs.writeShellScriptBin "cpu" ''${link ./cpu.sh}'';
  fgit = pkgs.writeShellScriptBin "fgit" ''${link ./fgit.sh} $@'';
  packages = pkgs.writeShellScriptBin "packages" ''${link ./packages.sh}'';
  wifiInterface = pkgs.writeShellScriptBin "wifiInterface" ''ip a | grep wlp | cut -d':' -f2| head -n1 |xargs'';
in
{
  home.packages = with pkgs; [
    c net ram cpu fgit packages wifiInterface
  ];
}

