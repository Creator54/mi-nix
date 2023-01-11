{
  fileSystems = {
    "/" = {
      device = "/dev/sdb2";
      fsType = "ext4";
      options = [ "noatime" ];
    };

    "/boot" = {
      device = "/dev/sdb1";
      fsType = "vfat";
    };

    "/home" = {
      device = "/dev/sda5";
      fsType = "ext4";
    };
  };

  swapDevices = [ { device = "/swapfile"; size = 4096; } ];
}
