{ config, pkgs, inputs, ... }: {

  users.users.elcarom = {
    isNormalUser = true;
    initialPassword = "password";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = [
      
    ];
  };

}

