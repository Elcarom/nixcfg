{ config, inputs, ouputs, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  networking.hostName = "vsvr-nos052";

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    useXkbConfig = true; # use xkb.options in tty.
  };

  services.xserver.xkb.layout = "fr";
  
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users.users.elcarom = {
    isNormalUser = true;
    initialPassword = "password";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
  };

  home-manager = {
	  useUserPackages = true;
	  extraSpecialArgs = { inherit inputs outputs; };
	  users.elcarom =
	    import ../../home/vsvr-nos052/${config.networking.hostName}.nix;
	};


  environment.systemPackages = with pkgs; [
    wget
    git
  ];

  services.openssh.enable = true;

  system.stateVersion = "25.05";

}