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
}
