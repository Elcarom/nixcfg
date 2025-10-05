{ config, pkgs, inputs, outputs, ... }: {

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
	    import ../../../../home/elcarom/${config.networking.hostName}.nix;
	};

}

