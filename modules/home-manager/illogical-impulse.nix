{ lib, config, pkgs, inputs, ... }:

let
  # Path to the dots directory
  dotsDir = inputs.illogical-impulse + "/dots";

  # Recursively collect files in dots/
  collectFiles = dir:
    let entries = builtins.readDir dir;
    in lib.concatMap (name:
      let
        full = dir + "/" + name;
      in if entries.${name} == "directory" then
        collectFiles full
      else
        [{
          src = full;
          # Compute the relative path under dotsDir safely
          rel = lib.replaceStrings [ (toString dotsDir + "/") ] [""] (toString full);
        }]
    ) (lib.attrNames entries);

  dotFiles = collectFiles dotsDir;

  # Filter out unwanted files (like .md or .git)
  dotFilesFiltered = lib.filter (f:
    !lib.hasSuffix ".md" f.rel &&
    !(lib.hasPrefix ".git" f.rel)
  ) dotFiles;

in {

  # Deploy dotfiles safely
  config.home.file = lib.listToAttrs (map (f: {
    name = lib.replaceStrings ["/"] ["__"] f.rel;
    value = {
      source = f.src;        # store path is fine
      destination = f.rel;   # relative path only
      type = "symlink";      # or "copy"
    };
  }) dotFilesFiltered);

  # Packages for Home Manager
  config.home.packages = with pkgs; [
    # AUDIO
    cava
    lxqt.pavucontrol-qt
    wireplumber
    libdbusmenu-gtk3
    playerctl

    # BACK LIGHT
    gammastep
    geoclue2
    brightnessctl
    ddcutil

    # BASIC
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

    # FONT THEMES
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

    # HYPRLAND
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

    # KDE
    kdePackages.bluedevil
    gnome-keyring
    kdePackages.plasma-nm
    kdePackages.polkit-kde-agent-1
    kdePackages.systemsettings

    # PYTHON
    uv
    gtk4
    libadwaita
    libsoup_3
    libportal-gtk4
    gobject-introspection
    sassc
    opencv

    # SCREEN CAPTURE
    swappy
    wf-recorder
    hyprshot
    tesseract
    slurp

    # TOOLKIT
    kdePackages.kdialog
    kdePackages.qt5compat
    kdePackages.wayland
    kdePackages.syntax-highlighting
    upower
    wtype
    ydotool

    # WIDGETS
    fuzzel
    glib
    quickshell
    swww
    translate-shell
    wlogout
  ];
}
