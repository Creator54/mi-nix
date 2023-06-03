{ config, pkgs, lib, ... }:

{
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluezFull;
    hsphfpd.enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        DefaultAudio = "headset";
        DefaultMic = "headset";
      };
      Audio = {
        AutoConnect = true;
      };
    };
  };

  services = {
    blueman.enable = true;
    dbus = {
      enable = true;
      packages = with pkgs; [ bluezFull ];
    };
  };

  systemd.services = {
    bluetoothUnblock = {
      description = "Unblock Bluetooth on startup";
      serviceConfig = {
        ExecStart = "/run/current-system/sw/bin/rfkill unblock all";
      };
      wantedBy = [ "multi-user.target" ];
    };
   # mpris-proxy = {
   #   description = "Mpris proxy";
   #   after = [ "network.target" "sound.target" ];
   #   serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
   #   wantedBy = [ "default.target" ];
   # };
  };
}

