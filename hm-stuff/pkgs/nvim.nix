{ config, pkgs, ... }:

let
  owner = "creator54";
  repo = "starter";
  rev = "main";
  nvimConfig = if builtins.pathExists "${config.home.homeDirectory}/nvim" then "${config.home.homeDirectory}/nvim" else
    let
      url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
      src = builtins.fetchTarball url;
      sha256 = builtins.hashFile src;
    in
    src;
in
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
  };

  home = {
    file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink nvimConfig;
    packages = [ pkgs.luajit ]; # dep for some plugins
  };
}

