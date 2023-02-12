{ config, ... }:

let
  uc =(import ../../userConfig.nix);
in
{
  boot = {
    resumeDevice = uc.fs.root;
    kernelParams = [ "resume_offset=${uc.hybridSleep.resume_offset}" ];
  };
  services.logind = {
    lidSwitch = "hybrid-sleep";
    lidSwitchDocked = "hybrid-sleep";
  };
}
