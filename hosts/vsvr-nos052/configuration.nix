{ config, inputs, outputs, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  networking.hostName = "vsvr-nos052";

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";

 	i18n.extraLocaleSettings = {
	  LC_ADDRESS = "fr_FR.UTF-8";
	  LC_IDENTIFICATION = "fr_FR.UTF-8";
	  LC_MEASUREMENT = "fr_FR.UTF-8";
	  LC_MONETARY = "fr_FR.UTF-8";
	  LC_NAME = "fr_FR.UTF-8";
	  LC_NUMERIC = "fr_FR.UTF-8";
	  LC_PAPER = "fr_FR.UTF-8";
	  LC_TELEPHONE = "fr_FR.UTF-8";
	  LC_TIME = "fr_FR.UTF-8";
	  };

  console = {
    useXkbConfig = true; # use xkb.options in tty.
  };

  services.xserver.xkb.layout = "fr";

  environment.systemPackages = with pkgs; [
    wget
    git
  ];

  services.openssh.enable = true;
  
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "virtio" ];

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  
  system.stateVersion = "25.05";

}