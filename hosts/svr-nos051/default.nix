{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    
    ../common/users/camille
    ../common/users/elcarom

    ../common/optional/mediamtx.nix
    ../common/optional/nvidia.nix
    ../common/optional/plasma.nix
  ];

  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  networking.hostName = "svr-nos051";

  hardware.graphics.enable = true;
  
  system.stateVersion = "25.05";

}
