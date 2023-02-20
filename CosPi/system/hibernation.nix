{ config, ... }:

let
  uc =(import ../../userConfig.nix);
in
{
  boot = {
    resumeDevice = uc.fs.root;
    kernelParams = [ "resume_offset=${uc.hibernation.resume_offset}" ];
  };


  # Suspend-then-hibernate everywhere
  services.logind = {
    lidSwitch = "suspend-then-hibernate";
    lidSwitchDocked = "suspend-then-hibernate";
    lidSwitchExternalPower = "suspend-then-hibernate";

    extraConfig = ''
      HandlePowerKey=hybrid-sleep
      IdleAction=suspend-then-hibernate
      IdleActionSec=5m
    '';
  };

  systemd.sleep.extraConfig = "HibernateDelaySec=30m";
}
