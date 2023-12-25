{ modulesPath, config, lib, pkgs, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
    ./hardware-configuration.nix
  ];
  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  services.openssh.enable = true;

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];

  users.users.root.openssh.authorizedKeys.keys = [
    # change this to your ssh key
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCf92RhBBf/ywH1v7c3eoUjW34GQXwdtlXfFBcyMuWgOAbVWMjGXJAxZM2KiZJwqaXQ/0QGoJ3U0sQcVRFu8LZW9bXO9viuFDOHu1UVcaT92WI/3VCGdAAWqmfBCigMhwDsuyoqiBdtess3akD16GBE+fB6Z0++oflFZF3Fe1RefNz5G61ywnNaQGyQUgD9NvK20QlQKRHnhbMAAIS4aOV2D0EDfSQpGQCocSt2wlr9YW+bc2duGu/qMCV9YQgRETDcmReg83EfaVLmpB6pnWM/hBqvE1t3BnxoFr2YtENKoE4Hsv8Tv1ceq3xOcfQpcOCUMzgu1wFm90o+sO0JsjN5 creator54@CosPi"
"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKU5ixgP9ygnri8aLOLnnLOMZru/UAet1qcGpNxESQYn mail@creator54.dev"
"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCnDjo5dUJKpOd3EKJgu9N18suPAfHF3drnicctzQqW/qXdR3bfe/vYCBCS6NvZ7d1sVKWU9vlxPqv/tF7zx/9xIZMzz+VmLW+Q6YabLOF1O6gfFkv4mXDgzY69p0h+E6etK1D41O3hpjnoHTToXiDmbzaDEKKNpbERgM0REoJdbRe1FEkBQyXdZh+7miJRM4kr9xhpRmM4ZBF7xIZR+K1Ha5+VhxAXDJprTeqNe915S7Vwf7sSwi2duCD+9rdZPYOGeB2g7wdr3clb+m79O7u8JRYsHbjmKmlGm0cveAqXx7E9mtL/3SuYr8Bl1+VtZNGa8MRLSjyUXA80/UFSLHVrzP6FniIBRQ7fNb6HDF88n2CNZaSFTIq/yptpR/BJM8Q4jUJjvDSScY+yKGgfh69A95w9Xx3IlLaY3FzOPlHXN9Hrju1F0500WZBNIDCgJkBk8DnBh9KWWH7SubxSZgAkz1bgAmFnbbMRQhGoYH4FSRI5ATiens6X+9LlLmurtFz9tUCFMT7Zps44LqlElNTFEsqubpoJz0XFYRxd0YdrZ8VN1Ajohz0NZpZEFwb73jDpFOZ9kqud46s2hSfHH8Z19MMTU1eUzBUc2G23npHSIw6g/8WPmb/sW0BpldBIt3DkpYxxdl8VSCRJPq2MpZA2d70omcbbQ+iuMyPhhJqSww== sarojkumar@criodo.com"
"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC9wiMgFixwVeBltzm9IaGtScIuuDvmfhqEShPXCvupyGfeXvKuovtHw28ZMF7C6bHCsfHZzIb71WCJFMoopIxqORW+H+Ya++UuT7kJ/vdm24qnPh4pj9wX159i7fUh3qIdL39sGYTIEFjL9zGjSYOhbx9b73W/sCREJ5NUx22HKYtKCESveWZJUiSxCmPL0MB9Xr3+IRfO0VTSteg76favRWrZ9MB2zpKAlEuUNwiqJR6Rbtc0XEVO2MmCfzdP3lfrRBPDXtx7F0tk76FnSts7jQDB6DVjWxdqRrh+jZzf3mg0nraoJ9W/H44ubOjtQGjfciANamEml0kGg2J00NrtDmzvm06M+G3H3GC7ylm8tAcz2AHZlMjRTxjLhxxSDCxGsCbLankJ0vAkqq2pmeBrCaJfcJzisblEEHKhoY1t7LUJHFboQ/XV5Bg6K8ZYMki2NAyOlO7FEOTzWE1+ZrYyqG85T9vifnVCiIAMVUR9aSXJF1Y04MkJV4o74eGPvGsRbWRLJ+wfnCkEzZgWNNEZOPiPM2eJeZFD4kn4+8aEpeavV7rVQAoWvlb2eQ1ZVsQwKghxsReJ0FjjTDA7NBxAnITsEoDnAnUdws9PfLeNTpoQ1pcv2HD3nq2LWGwd4u2Tv0cYwtjTyN6q5B7Qp6k2LV9FyMThWCjBRQyCTKT4Ww== hi.creator54@gmail.com"
  ];

  system.stateVersion = "23.11";
}
