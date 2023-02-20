{ config, ... }:

let
  uc =(import ../../userConfig.nix);
in
{
  boot = {
    resumeDevice = uc.fs.root;
    kernelParams = [ "resume_offset=${uc.hibernation.resume_offset}" ];
  };


  # hybrid-sleep everywhere
  services.logind = {
    lidSwitch = "hybrid-sleep";
    lidSwitchDocked = "hybrid-sleep";
    lidSwitchExternalPower = "hybrid-sleep";

    #HandlePowerKey works on short Press of powerButton, i.e <5 sec. else poweroff
    extraConfig = ''
      HandlePowerKey=hybrid-sleep
    '';
  };
}
