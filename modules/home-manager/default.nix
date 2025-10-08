{ config, pkgs, lib, inputs, ... }:

{
  options = import ./options.nix { inherit config pkgs lib inputs; };

  # Import submodules
  config = lib.mkMerge [
    (import ./theme.nix      { inherit config pkgs lib inputs; })
    (import ./packages.nix   { inherit config pkgs lib inputs; })
    (import ./hyprland.nix   { inherit config pkgs lib inputs; })
    (import ./quickshell.nix { inherit config pkgs lib inputs; })
  ];
}
