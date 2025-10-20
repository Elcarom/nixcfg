{ config, pkgs, inputs, ... }: {

  users.users.camille = {
    isNormalUser = true;
    initialPassword = "password";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = [ ];
  };

}

