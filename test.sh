#!/usr/bin/env bash
set -e -o pipefail

nixos-rebuild build-vm -I nixos-config=CosPi/configuration.nix
./result/bin/run-CosPi-vm
rm CosPi.qcow2
