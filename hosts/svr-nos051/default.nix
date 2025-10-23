{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    
    ../common/users/camille
    ../common/users/elcarom

    ../common/optional/mediamtx.nix
    ../common/optional/nvidia.nix
  ];

  networking.hostName = "svr-nos051";

  hardware.graphics.enable = true;
  
  system.stateVersion = "25.05";

}
