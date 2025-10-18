  
  {pkgs, ... }:
  {
    environment.systemPackages = with pkgs; [
        
    # # AUDIO #
    cava
    lxqt.pavucontrol-qt
    wireplumber
    libdbusmenu-gtk3
    playerctl

    # # BACK LIGNT#
    gammastep
    geoclue2
    brightnessctl
    ddcutil

    # # BASIC #
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

    # # FONT THEMES #
    #   adw-gtk-theme-git
    #   breeze-plus
    #   eza
    #   fish
    #   fontconfig
    #   kde-material-you-colors
    #   kitty
    #   matugen
    #   starship
    #   # ttf-readex-pro
    #   # ttf-jetbrains-mono-nerd
    #   # ttf-material-symbols-variable-git
    #   # ttf-rubik-vf
    #   # ttf-gabarito-git

    # # HYPRLAND #
    #   # hyprutils
    #   # hyprpicker
    #   # hyprlang
    #   # hypridle
    #   # hyprland-qt-support
    #   # hyprland-qtutils
    #   # hyprlock
    #   # hyprcursor
    #   # hyprwayland-scanner
    #   # hyprland
    #   # xdg-desktop-portal-hyprland
    #   wl-clipboard

    # # KDE #
    #   bluedevil
    #   gnome-keyring
    #   networkmanager
    #   plasma-nm
    #   polkit-kde-agent
    #   systemsettings

    # # PYTHON #
    #   # clang
    #   uv
    #   gtk4
    #   libadwaita
    #   libsoup3
    #   libportal-gtk4
    #   gobject-introspection
    #   sassc
    #   # python-opencv

    # # SCREEN CAPUTUER #
    #   swappy
    #   wf-recorder
    #   hyprshot
    #   tesseract
    #   slurp

    # # TOOLKIT #
    #   kdialog
    #   kdePackages.5compat
    #   kdePackages.base
    #   kdePackages.declarative
    #   kdePackages.imageformats
    #   kdePackages.multimedia
    #   kdePackages.positioning
    #   kdePackages.quicktimeline
    #   kdePackages.sensors
    #   kdePackages.svg
    #   kdePackages.tools
    #   kdePackages.translations
    #   kdePackages.virtualkeyboard
    #   kdePackages.wayland
    #   syntax-highlighting
    #   upower
    #   wtype
    #   ydotool

    # # WIDGETS #
    #   fuzzel
    #   glib2 # for `gsettings` it seems?
    #   # hypridle
    #   # hyprutils
    #   # hyprlock
    #   # hyprpicker
    #   nm-connection-editor
    #   quickshell
    #   swww
    #   translate-shell
    #   wlogout
    
    ];
  }
