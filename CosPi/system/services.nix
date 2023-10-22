{ config, pkgs, lib, ... }:

let
  uc = (import ../../userConfig.nix);
in

{
  services = {
    xserver = {
      enable = true;
      layout = "us";
      libinput.enable = true; 				# touchpad support generally enabled by most display managers
      displayManager.sx.enable = true;  #minimal replacement for startx
      videoDrivers = [ "amdgpu" ];
      deviceSection = ''
        Option "TearFree" "true"
      '';
      excludePackages = [ pkgs.xterm ];
    };

    udev.extraRules = lib.mkMerge [
      # autosuspend USB devices
      ''ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="auto"''
      # autosuspend PCI devices
      ''ACTION=="add", SUBSYSTEM=="pci", TEST=="power/control", ATTR{power/control}="auto"''
      # disable Ethernet Wake-on-LAN
      ''ACTION=="add", SUBSYSTEM=="net", NAME=="enp*", RUN+="${pkgs.ethtool}/sbin/ethtool -s $name wol d"''
    ];

    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_BAT="schedutil";
        CPU_SCALING_GOVERNOR_ON_AC="schedutil";
        START_CHARGE_THRESH_BAT0=40;
        STOP_CHARGE_THRESH_BAT0=50;
        CPU_MAX_PERF_ON_AC=100;
        CPU_MAX_PERF_ON_BAT=70;
        SOUND_POWER_SAVE_ON_AC=0;
        SOUND_POWER_SAVE_ON_BAT=1;
      };
    };

    getty = {
      greetingLine = "";
      helpLine = "";
      autologinUser = "${uc.user}";
    };
    thermald.enable = true;
    upower.enable = true;
    hdapsd.enable = lib.mkDefault true;
    gnome.gnome-keyring.enable = true; #fails to save if enabled via home-manager
  };

  # systemd services which i dont like/use mostly cuz increases boot time and i find no issues not having them
  systemd.services = {
    systemd-udev-settle.enable = false;
    NetworkManager-wait-online.enable = false;
    firewall.enable = false;
    systemd-journal-flush.enable = false;
    lvm2-activation-early.enable = false;
    lvm2-activation.enable = false;
  };

  programs = {
    light.enable = true;
    nix-ld.enable = true; #Run unpatched dynamic binaries on NixOS., check : https://github.com/Mic92/nix-ld
  };
  sound.enable = true;
}

