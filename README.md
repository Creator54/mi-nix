# MI-NIX : My Nix Config
Installs NixOS and Home-Manager as NixOS Module to manage user with my configs.

## To build test VM with this config on a NixOS System, plymouth needs to be disabled 

```bash
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.11.tar.gz home-manager
sudo nix-channel --add https://nixos.org/channels/nixos-22.11 nixos

nixos-rebuild build-vm -I nixos-config=CosPi/configuration.nix
```
## To run the testVM

```bash
./result/bin/run-CosPi-vm
```

