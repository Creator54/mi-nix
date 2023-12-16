{ ... }:

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

    #https://wiki.archlinux.org/title/getty
    #NAutoVTs specifys no of tty's we can have
    extraConfig = ''
      HandlePowerKey=hybrid-sleep
      NAutoVTs=1
    '';
  };
}
