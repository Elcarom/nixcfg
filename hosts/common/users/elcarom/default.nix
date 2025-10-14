{ config, pkgs, inputs, ... }: {

  users.users.elcarom = {
    isNormalUser = true;
    initialPassword = "password";
    extraGroups = [ "wheel" "video"]; # Enable ‘sudo’ for the user.
    packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
  };

  home-manager.users.elcarom = import ../../../../home/elcarom/${config.networking.hostName}.nix;

}

