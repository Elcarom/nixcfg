{ lib, config, pkgs, inputs, ... }:

let
  dotConfigPath = "${inputs.illogicalImpulse}/dots/.config";

  # Recursively collect all relative file paths in .config
  getConfigFilesRecursive = path:
    let
      entries = builtins.readDir path;
      entryNames = builtins.attrNames entries;

      filePaths = lib.concatMap (name:
        let fullPath = "${path}/${name}";
        in if entries.${name} == "directory" then
          map (sub: "${name}/${sub}") (getConfigFilesRecursive fullPath)
        else
          [ name ]
      ) entryNames;
    in filePaths;

  configFiles = getConfigFilesRecursive dotConfigPath;

in {
  xdg.configFile = builtins.listToAttrs (map (relPath: {
    name = relPath;
    value.source = "${dotConfigPath}/${relPath}";
  }) configFiles);

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
}
