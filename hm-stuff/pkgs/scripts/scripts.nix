{ config, pkgs, lib, ... }:
let
  link = config.lib.file.mkOutOfStoreSymlink;
  c = pkgs.writeShellScriptBin "c" ''${link ./c.sh} $@'';
  net = pkgs.writeShellScriptBin "net" ''${link ./net.sh} $@'';
  wifiInterface = pkgs.writeShellScriptBin "wifiInterface" ''ip a | grep wlp | cut -d':' -f2| head -n1 |xargs'';
in
{
  home.packages = with pkgs; [
    c net wifiInterface
  ];
}

