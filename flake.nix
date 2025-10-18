{
  description = "NixOS Flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

  illogicalImpulse = {
      url = "github:end-4/dots-hyprland";
      flake = false;
    };

  };

  outputs = { self, nixpkgs, illogicalImpulse, ... }@inputs:
    let
      inherit (self) outputs;
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      packages =
        forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      overlays = import ./overlays { inherit inputs; };
      nixosConfigurations = {
        vsvr-nos052 = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
            illogicalImpulse = inputs.illogicalImpulse;
          };
          modules = [ ./hosts/vsvr-nos052 ];
        };
      };
    };
}
