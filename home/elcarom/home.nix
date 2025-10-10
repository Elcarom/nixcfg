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
}