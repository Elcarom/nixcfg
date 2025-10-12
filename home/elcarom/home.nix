{ config, lib, pkgs, inputs,... }:

{
  
  home.username = lib.mkDefault "elcarom";
  home.homeDirectory = lib.mkDefault "/home/${config.home.username}";

  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = [

  ];

  home.file = {

  };

  home.sessionVariables = {

  };

  programs.home-manager.enable = true;
  inputs.illogical-impulse = {
    enable = true;

    hyprland = {
        # Use customized Hyprland build
        package = pkgs.hyprland;
        xdgPortalPackage = pkgs.xdg-desktop-portal-hyprland;

        # Enable Wayland ozone
        ozoneWayland.enable = true;
    };

    # Dotfiles configurations
    dotfiles = {
        fish.enable = true;
        kitty.enable = true;
    };
};
}