{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./system/fileSystems.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" ];
      kernelModules = [ "i915" ];
    };
    kernelModules = [ "kvm-intel" ];

    # https://discourse.nixos.org/t/thinkpad-t470s-power-management/8141
    extraModprobeConfig = lib.mkMerge [
      # idle audio card after one second
      "options snd_hda_intel power_save=1"
      # enable wifi power saving (keep uapsd off to maintain low latencies)
      "options iwlwifi power_save=1 uapsd_disable=1"
    ];

    # https://github.com/NixOS/nixpkgs/issues/18356
    blacklistedKernelModules = [ "nouveau" ];

    kernelParams = [
      "i915.enable_fbc=1"
      "i915.enable_psr=2"
      "intel_pstate=disable"
    ];
  };

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    opengl = {
      enable = true;
      driSupport = true; #hardware acceleration for the Mesa implementation of OpenGL
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
        intel-media-driver
      ];
    };
    pulseaudio = {
      enable = true;
      support32Bit = true;
      package = pkgs.pulseaudioFull;
      extraConfig = "load-module module-switch-on-connect";
    };
  };
}
