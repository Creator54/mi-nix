# MI-NIX : My Nix Config
Installs NixOS and Home-Manager as NixOS Module to manage user with my configs.

## To build and run a test VM with this config on a NixOS System

```bash
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.11.tar.gz home-manager
sudo nix-channel --add https://nixos.org/channels/nixos-22.11 nixos

./testVM
```
