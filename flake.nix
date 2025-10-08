{
  description = "Illogical Impulse NixOS & Home Manager Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";

    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    hyprland-plugins.inputs.hyprland.follows = "hyprland";

    quickshell.url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    quickshell.inputs.nixpkgs.follows = "nixpkgs";

    systems.url = "github:nix-systems/default-linux";
    systems.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    illogical-impulse-dotfiles.url = "github:end-4/dots-hyprland";
    illogical-impulse-dotfiles.flake = false;
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "i686-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      packages = forAllSystems (system:
        import ./pkgs { inherit system pkgs inputs; }
      );

      overlays = import ./overlays { inherit inputs; };

      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        vsvr-nos052 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs self; };
          modules = [ ./hosts/vsvr-nos052.nix ];
        };
      };

      homeConfigurations = {
        "elcarom@vsvr-nos052" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs self; };
          modules = [ ./home/elcarom/vsvr-nos052.nix ];
        };
      };
    };
}
