{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.illogical-impulse;
  system = pkgs.system;

  selfPkgs =
    if builtins.pathExists ../pkgs then
      import ../pkgs { inherit pkgs; }
    else
      {};
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # --- AUDIO ---
      cava
      lxqt.pavucontrol-qt
      wireplumber
      libdbusmenu-gtk3
      playerctl

      # --- BACKLIGHT ---
      brightnessctl
      ddcutil

      # --- BASICS ---
      axel
      bc
      cliphist
      curl
      rsync
      wget
      libqalculate
      ripgrep
      jq
      fish
      foot
      fuzzel
      matugen
      mpv
      mpvpaper
      xdg-user-dirs

      # --- FONTS & THEMES ---
      adw-gtk3
      eza
      python313Packages.kde-material-you-colors
      material-symbols
      rubik
      inputs.nur.legacyPackages.${system}.repos.skiletro.gabarito
      selfPkgs.illogical-impulse-oneui4-icons

      # --- HYPRLAND ---
      wl-clipboard

      # --- KDE / POLKIT ---
      kdePackages.bluedevil
      gnome-keyring
      kdePackages.plasma-nm
      kdePackages.polkit-kde-agent-1

      # --- SCREEN CAPTURE ---
      swappy
      wf-recorder
      hyprshot
      tesseract
      slurp

      # --- TOOLKIT / UTILITIES ---
      upower
      wtype
      ydotool

      # --- PYTHON ENVIRONMENT ---
      libsoup_3
      libportal-gtk4
      gobject-introspection
      sassc
      opencv
      (python3.withPackages (ps: with ps; [
        build
        pillow
        setuptools-scm
        wheel
        pywayland
        psutil
        materialyoucolor
        libsass
        material-color-utilities
        setproctitle
      ]))

      # --- WIDGETS ---
      glib
      swww
      translate-shell
      wlogout
    ]
    ++ (with pkgs.nerd-fonts; [
      ubuntu
      ubuntu-mono
      jetbrains-mono
      caskaydia-cove
      fantasque-sans-mono
      mononoki
      space-mono
    ]);

    services = {
      gammastep = {
        enable = true;
        provider = "geoclue2";
      };
      network-manager-applet.enable = true;
    };
  };
}
