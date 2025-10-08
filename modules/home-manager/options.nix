{ config, pkgs, lib, inputs, ... }:
with lib;

let
  illogical-impulse-dotfiles = inputs.illogical-impulse-dotfiles;
in
{
  options.illogical-impulse = {
    enable = mkEnableOption "Enable illogical-impulse";

    theme.cursor = {
      theme = mkOption {
        type = types.str;
        default = "Adwaita";
        description = "Cursor theme name";
      };
      package = mkOption {
        type = types.package;
        default = pkgs.adwaita-icon-theme;
        description = "Cursor theme package";
      };
    };

    hyprland = {
      monitor = mkOption {
        type = types.listOf types.str;
        default = [ ",preferred,auto,1" ];
        description = "Monitor preferences for Hyprland";
      };
      package = mkOption {
        type = types.package;
        default = pkgs.hyprland;
        description = "Hyprland package";
      };
      xdgPortalPackage = mkOption {
        type = types.package;
        default = pkgs.xdg-desktop-portal-hyprland;
        description = "xdg-desktop-portal package for Hyprland";
      };
      ozoneWayland.enable = mkEnableOption "Set NIXOS_OZONE_WL=1";
    };

    dotfiles = {
      kitty.enable = mkEnableOption "Enable illogical-impulse kitty";
      fish.enable = mkEnableOption "Enable illogical-impulse fish";
      starship.enable = mkEnableOption "Enable illogical-impulse starship";
      quickshell.enable = mkEnableOption "Enable Quickshell integration";
    };
  };
}
