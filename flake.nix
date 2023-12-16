{
  description = "My NIX-Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { nixpkgs, ... } @ inputs : {
    nixosConfigurations = {
      cospi = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; }; # this is the important part for hyprland
        system = "x86_64-linux";
        modules = [
          ./CosPi/configuration.nix
        ];
      };
    };
  };
}

