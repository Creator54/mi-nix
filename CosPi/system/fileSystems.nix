{
  fileSystems = {
    "/" = {
      device = "/dev/sda2";
      fsType = "ext4";
      options = [ "noatime" ];
    };

    "/boot" = {
      device = "/dev/sda1";
      fsType = "vfat";
    };

    "/home" = {
      device = "/dev/sda3";
      fsType = "ext4";
    };
  };

  swapDevices = [ { device = "/swapfile"; size = 4096; } ];
}
