{ config, pkgs, ... }:
let
  doom = pkgs.writeShellScriptBin "doom" ''${config.lib.file.mkOutOfStoreSymlink (config.home.homeDirectory + "/.config/emacs/bin/doom")} "$@"'';
in
{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.vterm
    ];
  };

  services.emacs.enable = true;

  systemd.user.services.doom-sync = {
    Unit.Description = "Doom Emacs fetch config";
    Service = {
      ExecStart = "${pkgs.bash}/bin/bash -c 'DOOM=\"${config.home.homeDirectory}/.config/emacs\"; if [ ! -d \"$DOOM\" ] || [ -z \"$(find \"$DOOM\" -maxdepth 0 -empty)\" ]; then ${pkgs.git}/bin/git clone --depth=1 https://github.com/doomemacs/doomemacs.git \"$DOOM\"; fi;'";
      RemainAfterExit = true;
    };
    Install.WantedBy = [ "default.target" ];
  };

  home.packages = with pkgs; [
    doom
    gnutls
    aspell
    aspellDicts.en
    aspellDicts.es
  ];
}

