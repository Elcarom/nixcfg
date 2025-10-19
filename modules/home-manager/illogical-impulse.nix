{ lib, config, pkgs, inputs, ... }:


let
  
  dotConfigPath = "${inputs.illogicalImpulse}/dots/.config";
  dotLocalPath = "${inputs.illogicalImpulse}/dots/.local";

in {
  
  config = {
    
    home.file = {
      ".config" = {
        source = dotConfigPath;
        recursive = true; # This copies the directory recursively
      };

      ".local" = {
      source = dotLocalPath;
      recursive = true;
      };

      ".config/quickshell" = {
        source = dotConfigPath/quickshell/ii";
        recursive = true;
      };

    };

    home.packages = with pkgs; [
      cava
      lxqt.pavucontrol-qt
      wireplumber
      libdbusmenu-gtk3
      playerctl
      gammastep
      geoclue2
      brightnessctl
      ddcutil
      axel
      bc
      coreutils
      cliphist
      cmake
      curl
      rsync
      wget
      ripgrep
      jq
      meson
      xdg-user-dirs
      adw-gtk3
      eza
      fish
      fontconfig
      python313Packages.kde-material-you-colors
      kitty
      matugen
      starship
      jetbrains-mono
      material-symbols
      rubik
      hyprutils
      hyprpicker
      hyprlang
      hypridle
      hyprland-qt-support
      hyprland-qtutils
      hyprlock
      hyprcursor
      hyprwayland-scanner
      hyprland
      xdg-desktop-portal-hyprland
      wl-clipboard
      kdePackages.bluedevil
      gnome-keyring
      kdePackages.plasma-nm
      kdePackages.polkit-kde-agent-1
      kdePackages.systemsettings
      uv
      gtk4
      libadwaita
      libsoup_3
      libportal-gtk4
      gobject-introspection
      sassc
      opencv
      swappy
      wf-recorder
      hyprshot
      tesseract
      slurp
      kdePackages.kdialog
      kdePackages.qt5compat
      kdePackages.wayland
      kdePackages.syntax-highlighting
      upower
      wtype
      ydotool
      fuzzel
      glib
      quickshell
      swww
      translate-shell
      wlogout
    ];
  };
}
