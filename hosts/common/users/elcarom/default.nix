{ config, pkgs, inputs, ... }: {

  imports = [./packages.nix];
  
  users.users.elcarom = {
    isNormalUser = true;
    initialPassword = "password";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = [ ];
  };

}

