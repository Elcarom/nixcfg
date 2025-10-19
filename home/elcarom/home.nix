{ config, lib, pkgs, inputs, ... }:

{
    
  home.username = lib.mkDefault "elcarom";
  home.homeDirectory = lib.mkDefault "/home/${config.home.username}";

  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = [
    pkgs.kitty
  ];

  home.file = {

  };

  home.sessionVariables = {

  };

  programs.home-manager.enable = true;
  fonts.fontconfig.enable = false;

  illogical-impulse = {
    # Enable the dotfiles suite
    enable = true;

    # Dotfiles configurations
    dotfiles = {
        fish.enable = true;
        kitty.enable = true;
    };

  };
}
