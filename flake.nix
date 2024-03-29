{
  description = "My NIX-Flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/release-23.11";
    };
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      cospi = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./CosPi/configuration.nix
        ];
      };
    };
  };
}

