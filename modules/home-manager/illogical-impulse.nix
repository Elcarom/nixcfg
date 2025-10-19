{ lib, config, pkgs, inputs, ... }:

let
  dotsDir = inputs.illogical-impulse + "/dots";

  # Recursively collect all files under dotsDir
  collectFiles = dir:
    let entries = builtins.readDir dir;
    in lib.concatMap (name:
      let full = dir + "/" + name;
          rel  = lib.replaceStrings [toString dotsDir + "/"] [""] (toString full);
      in if entries.${name} == "directory" then
           collectFiles full
         else
           [{ src = full; rel = rel; }]
    ) (lib.attrNames entries);

  dotFilesFiltered = lib.filter (f: 
    !lib.hasSuffix ".md" f.rel && !(lib.hasPrefix ".git" f.rel)
  ) (collectFiles dotsDir);

in {
  config.home.file = lib.listToAttrs (map (f: {
    name = lib.replaceStrings ["/"] ["__"] f.rel;
    value = {
      source = f.src;       # store path is fine
      destination = f.rel;  # pure relative string
      type = "symlink";
    };
  }) dotFilesFiltered);

  config.home.packages = with pkgs; [
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
