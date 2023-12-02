{
  host = "CosPi";
  user = "creator54";
  userEmail = "hi.creator54@gmail.com";
  userHashedPass = "$1$.recy8UF$9gm683TL0.8kAdpRssbhx/";
  stateVersion = "23.05";
  fs = {
    boot = "/dev/disk/by-uuid/7EE7-7EF9";
    root = "/dev/disk/by-uuid/df4e12d1-ce05-4218-a103-fcaabddb01ab";
    home = "/dev/disk/by-uuid/b204f710-41af-41df-ac9d-3fd38147e0f3";
  };
  hibernation = {
    enable = false;
    resume_offset="23123968"; #sudo filefrag -v /swapfile | awk '{if($1=="0:"){print $4}}'
  };
}


#  fileSystems."/" =
#    { device = "/dev/disk/by-uuid/df4e12d1-ce05-4218-a103-fcaabddb01ab";
#      fsType = "ext4";
#    };
#
#  fileSystems."/boot" =
#    { device = "/dev/disk/by-uuid/7EE7-7EF9";
#      fsType = "vfat";
#    };
#
#  fileSystems."/home" =
#    { device = "/dev/disk/by-uuid/b204f710-41af-41df-ac9d-3fd38147e0f3";
#      fsType = "ext4";
#    };
#
