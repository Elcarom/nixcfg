{ config, lib, pkgs, inputs, ... }:
let
  hyprConf = config.illogical-impulse.hyprland;
  enabled = config.illogical-impulse.enable;
in
{
  config = lib.mkIf enabled {
    home.packages = with pkgs; [
      hyprpicker
      hyprlock
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      xwayland.enable = true;
      package = hyprConf.package;
      portalPackage = hyprConf.xdgPortalPackage;

      settings = {
        env = [
          "GIO_EXTRA_MODULES, ${pkgs.gvfs}/lib/gio/modules:$GIO_EXTRA_MODULES"
        ];
        exec = ["hyprctl dispatch submap global"];
        submap = "global";
        debug.disable_logs = false;
        monitor = hyprConf.monitor;
      };

      extraConfig = ''
        source=~/.config/hypr/custom/env.conf
        source=~/.config/hypr/custom/general.conf
        source=~/.config/hypr/custom/rules.conf
        source=~/.config/hypr/custom/keybinds.conf
      '';
    };

    services.hypridle.enable = true;
  };
}
