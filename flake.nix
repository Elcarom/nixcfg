{
  description = "NixOS Flake";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    illogical-impulse-dotfiles = {
      url = "github:end-4/dots-hyprland";
      flake = false;
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, home-manager, nur, illogical-impulse-dotfiles, ... }@inputs:
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
    packages = forAllSystems (system:
      import ./pkgs nixpkgs.legacyPackages.${system}
    );

    homeManagerModules.default = import ./modules/home-manager/default.nix {
      inherit illogical-impulse-dotfiles inputs;
    };

    overlays = import ./overlays { inherit inputs; };

    nixosConfigurations = {
      vsvr-nos052 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [ ./hosts/vsvr-nos052 ];
      };
    };

    homeConfigurations = {
      "elcarom@vsvr-nos052" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs outputs; };
        modules = [
          ./home/elcarom/vsvr-nos052.nix
          self.homeManagerModules.default
        ];
      };
    };
  };
}
