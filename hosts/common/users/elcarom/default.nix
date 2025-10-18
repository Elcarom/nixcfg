{ config, pkgs, inputs, ... }: {

  users.users.elcarom = {
    isNormalUser = true;
    initialPassword = "password";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
  };

}

