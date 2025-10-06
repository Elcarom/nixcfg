{ config, lib, pkgs, ... }:

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
  
  programs.caelestia = {
  enable = true;
  systemd = {
    enable = false; # if you prefer starting from your compositor
    target = "graphical-session.target";
    environment = [];
  };
  settings = {
    bar.status = {
      showBattery = false;
    };
    paths.wallpaperDir = "~/Images";
  };
  cli = {
    enable = true; # Also add caelestia-cli to path
    settings = {
      theme.enableGtk = false;
    };
  };
};
}
