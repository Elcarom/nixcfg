{
  description = "NixOS Flake";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    }

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    systems = {
      url = "github:nix-systems/default-linux";
      inputs.nixpkgs.follows = "nixpkgs";
    }

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    illogical-impulse-dotfiles = {
      url = "github:end4/dots-hyprland";
      flake = false;
    };
    
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = { self, home-manager, nixpkgs, ... }@inputs:
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
      homeManagerModules = import ./modules/home-manager;
      nixosConfigurations = {
        vsvr-nos052 = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/vsvr-nos052 ];
        };
      };
      homeConfigurations = {
        "elcarom@vsvr-nos052" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/elcarom/vsvr-nos052.nix ];
        };
      };
    };
}
