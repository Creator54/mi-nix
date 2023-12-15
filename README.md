# MI-NIX : My Nix Config
Installs NixOS and Home-Manager as NixOS Module to manage user with my configs.

## To build and test this config on a NixOS System

### With Flakes
```bash
sudo nixos-rebuild switch --impure --flake .#cospi
```

### Without Flakes
```bash
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.11.tar.gz home-manager
sudo nix-channel --add https://nixos.org/channels/nixos-22.11 nixos
sudo nix-channel --update

sudo nixos-rebuild switch -I ./CosPi/configuration.nix
reboot
```

