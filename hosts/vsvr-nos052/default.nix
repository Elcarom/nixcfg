{
  imports = [
    ./hardware-configuration.nix

    ../common/global

    ../common/users/camille
    ../common/users/elcarom
    
    ../common/optional/plasma.nix
  ];

  networking.hostName = "vsvr-nos052";

  hardware.graphics.enable = true;
  
  system.stateVersion = "25.05";

}
