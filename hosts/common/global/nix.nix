{ lib, inputs, outputs, ... }: {

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages
    ];

    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [
        "root"
        "@wheel"
      ]; # Set users that are allowed to use the flake command
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
    optimise.automatic = true;
    
    registry = (lib.mapAttrs (_: flake: { inherit flake; }))
      ((lib.filterAttrs (_: lib.isType "flake")) inputs);
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}")
      ((lib.filterAttrs (_: lib.isType "flake")) inputs);
  };
}
