{
  options = import ./options.nix;
  quickshell = import ./quickshell.nix;
  hyprland = import ./hyprland.nix;
  packages = import ./packages.nix inputs;
}