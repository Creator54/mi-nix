# MI-NIX : My Nix Config
Installs NixOS and Home-Manager as NixOS Module to manage user with my configs.

## To build test VM with this config on a NixOS System

```bash
nixos-rebuild build-vm -I nixos-config=CosPi/configuration.nix
```
## To run the testVM

```bash
./result/bin/run-CosPi-vm
```
