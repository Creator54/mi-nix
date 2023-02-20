{ config, pkgs, lib, ... }:
let
  nvimConfig = if builtins.pathExists "${config.home.homeDirectory}/nvim/" then "${config.home.homeDirectory}/nvim/" else (
    pkgs.fetchFromGitHub{
      owner = "creator54";
      repo = "starter";
      rev = "main";
      sha256 = "sha256-H7LqDudrCxK1jVJa2MVzUD3ulVy3LcQPFEHZPyjCF4c=";
    }
  );
in
{
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink nvimConfig;
  programs.neovim.enable = true;
}

