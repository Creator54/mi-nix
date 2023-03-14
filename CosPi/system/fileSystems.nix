let
  fs = (import ../../userConfig.nix).fs;
in
{
  fileSystems = {
    "/" = {
      device = fs.root;
      fsType = "ext4";
      options = [ "noatime" ];
    };

    "/boot" = {
      device = fs.boot;
      fsType = "vfat";
    };

    "/home" = {
      device = fs.home;
      fsType = "ext4";
    };
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
    numDevices = 1;
    priority = 5; #matters only when using multiple swap devices
  };

  swapDevices = [ { device = "/swapfile"; size = 8192; } ];
}
