# modules/home-manager/default.nix
{ illogical-impulse-dotfiles, inputs }: { config, pkgs, lib, ... }:
{
  imports = [
    (import ./options.nix illogical-impulse-dotfiles { inherit config pkgs lib; })
    (import ./quickshell.nix illogical-impulse-dotfiles { inherit inputs config pkgs lib; })
    (import ./hyprland.nix illogical-impulse-dotfiles { inherit config pkgs lib; })
    (import ./packages.nix { inherit inputs config pkgs lib; })
  ];
}
