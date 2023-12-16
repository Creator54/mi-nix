{config, pkgs, ...}:
#let
#  flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
#
#  hyprland = (import flake-compat {
#    src = builtins.fetchTarball "https://github.com/hyprwm/Hyprland/archive/287f313.tar.gz";
#  }).defaultNix;
#in
{
  imports = [
  ./hyprland-config.nix
  ];
  systemd.user.services.hyprland-sync = {
    Unit.Description = "Keep Hyprland config synlink and outside Nix-Store";
    Service = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "ln -s ./hypr.conf \"${config.home.homeDirectory}/.config/hypr/hypr.conf\"";
    };
    Install.WantedBy = [ "multi-user.target" ];
  };
  wayland.windowManager.hyprland.enable = true;
}
