{ lib, config, pkgs, inputs, ... }:

let
  dotsDir = inputs.illogical-impulse + "/dots";

  mkDotFiles = path:
    let entries = builtins.readDir path;
    in lib.concatMap (name:
      let full = path + "/" + name;
      in if (entries.${name} == "directory") then
        mkDotFiles full
      else
        [{
          src = full;
          rel = lib.removePrefix (toString dotsDir + "/") (toString full);
        }]
    ) (lib.attrNames entries);

  dotFiles = mkDotFiles dotsDir;

  dotFilesFiltered = lib.filter (f:
    !lib.hasSuffix ".md" f.rel &&
    !(lib.hasPrefix ".git" f.rel)
  ) dotFiles;

in {
  config.home.file = lib.listToAttrs (map (f: {
    name = lib.replaceStrings ["/"] ["__"] f.rel;
    value = {
      source = f.src;
      destination = f.rel;
      type = "symlink";
    };
  }) dotFilesFiltered);

  config.home.packages = with pkgs; [
    
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
    adw-gtk3
    #   breeze-plus
    eza
    fish
    fontconfig
    python313Packages.kde-material-you-colors
    kitty
    matugen
    starship
    #   ttf-readex-pro
    jetbrains-mono
    material-symbols
    rubik
    #   ttf-gabarito-git

    # # HYPRLAND #
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

    # # KDE #
    kdePackages.bluedevil
    gnome-keyring
    kdePackages.plasma-nm
    kdePackages.polkit-kde-agent-1
    kdePackages.systemsettings

    # # PYTHON #
    #   clang
    uv
    gtk4
    libadwaita
    libsoup_3
    libportal-gtk4
    gobject-introspection
    sassc
    opencv

    # # SCREEN CAPUTRE #
    swappy
    wf-recorder
    hyprshot
    tesseract
    slurp

    # # TOOLKIT #
    kdePackages.kdialog
    kdePackages.qt5compat
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
    kdePackages.wayland
    kdePackages.syntax-highlighting
    upower
    wtype
    ydotool

    # # WIDGETS #
    fuzzel
    glib
    #   nm-connection-editor
    quickshell
    swww
    translate-shell
    wlogout
    
    ];

}
