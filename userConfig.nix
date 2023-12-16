{
  host = "CosPi";
  user = "creator54";
  userEmail = "hi.creator54@gmail.com";
  userHashedPass = "$y$j9T$xIo2r2i0pl55kKgQx0X5S1$0VtDoXgpYwcQieQ7pZ08rEhXRFHSPKgvkPw9OS4uTP3"; #mkpasswd
  stateVersion = "23.11";
  fs = {
    boot = "/dev/disk/by-uuid/7EE7-7EF9";
    root = "/dev/disk/by-uuid/df4e12d1-ce05-4218-a103-fcaabddb01ab";
    home = "/dev/disk/by-uuid/b204f710-41af-41df-ac9d-3fd38147e0f3";
  };
  hibernation = {
    enable = true;
    resume_offset="23123968"; #sudo filefrag -v /swapfile | awk '{if($1=="0:"){print $4}}'
  };
}
