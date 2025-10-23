{ config, lib, pkgs, modulesPath, ... }:

{

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "thunderbolt" "usbhid"];

  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "xfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/boot";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  networking.networkmanager.enable = true;
  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}