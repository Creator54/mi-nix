{ config, ... }:

let
  userConfig =(import ../../userConfig.nix);
  hs = userConfig.hybridSleep;
in
{
  boot = {
    resumeDevice = userConfig.fs.root;
    kernelParams = [ "resume_offset=${hs.resume_offset}" ];
  };
}
