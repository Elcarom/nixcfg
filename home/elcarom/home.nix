{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.illogical-impulse.homeManagerModules.default
  ];

  home.username = "elcarom";
  home.homeDirectory = "/home/elcarom";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
  programs.hyprland.enable = true;

  programs.illogical-impulse = {
    enable = true;

    hyprland = {
      package = hypr.hyprland;
      xdgPortalPackage = hypr.xdg-desktop-portal-hyprland;
      ozoneWayland.enable = true;
    };

    dotfiles = {
      fish.enable = true;
      kitty.enable = true;
      starship.enable = true;
      quickshell.enable = true;
    };
  };
}
