{
  description = "Illogical Impulse NixOS & Home Manager Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    illogical-impulse-dotfiles.url = "github:end-4/dots-hyprland";
    illogical-impulse-dotfiles.flake = false;
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" ];
  in
  {
    packages = nixpkgs.lib.genAttrs systems (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
        import ./pkgs { inherit pkgs inputs system; }
    );

    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      vsvr-nos052 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs self; };
        modules = [ ./hosts/vsvr-nos052 ];
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
