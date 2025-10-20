{ config, inputs, outputs, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  networking.hostName = "vsvr-nos052";

  console = {
    useXkbConfig = true;
  };

  services.xserver.xkb.layout = "fr";

  environment.systemPackages = with pkgs; [
    wget
    git
  ];
  
  services.openssh.enable = true;
  
  hardware.graphics.enable = true;
  
  system.stateVersion = "25.05";

}