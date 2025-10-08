{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.illogical-impulse;
  illogical-impulse-dotfiles = inputs.illogical-impulse-dotfiles;
in
{
  config = lib.mkIf (cfg.enable && cfg.dotfiles.quickshell.enable) {
    home.packages = [ inputs.quickshell.packages.${pkgs.system}.default ];

    home.sessionVariables.ILLOGICAL_IMPULSE_VIRTUAL_ENV =
      "~/.local/state/quickshell/.venv";

    xdg.configFile."quickshell".source =
      "${illogical-impulse-dotfiles}/.config/quickshell";
  };
}
