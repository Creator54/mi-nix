{ pkgs, lib, ... }:
let
  localDwm = /home/${(import ../../userConfig.nix).user}/dwm;
  localDwmBlocks = /home/${(import ../../userConfig.nix).user}/dwmblocks;
  dwm = pkgs.dwm.overrideAttrs (old: {
    src = localDwm;
    nativeBuildInputs = with pkgs; [ #writing once works for both currently, sort of bug and feature
      xorg.libX11.dev
      xorg.libXft
      imlib2
      xorg.libXinerama
    ];
  });
  dwmblocks = pkgs.dwmblocks.overrideAttrs (old: {
    src = if builtins.pathExists localDwmBlocks then localDwmBlocks else builtins.fetchTarball "https://github.com/creator54/dwmblocks/tarball/master";
  });
in
{
  home.packages = [ dwm dwmblocks ];
}
