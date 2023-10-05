{
  inputs = {
    nixpkgs.url="github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, home-manager }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in
  {
    home-config =  home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./hm-stuff/home.nix
        ];
    };
  };
}
