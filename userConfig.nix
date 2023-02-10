{
  host = "CosPi";
  user = "creator54";
  userEmail = "hi.creator54@gmail.com";
  userHashedPass = "$1$.recy8UF$9gm683TL0.8kAdpRssbhx/";
  stateVersion = "22.11";
  fs = {
    boot = "/dev/sda1";
    root = "/dev/sda2";
    home = "/dev/sda3";
  };
  hybridSleep = {
    enable = true;
    resume_offset="2244125"; #sudo filefrag -v /swapfile | awk '{if($1=="0:"){print $4}}'
  };
}
