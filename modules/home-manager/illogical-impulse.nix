{ lib, config, pkgs, inputs, ... }:

let
  # Base dots directory (ensure a proper path string)
  dotsDirRaw = builtins.toPath (inputs.illogical-impulse + "/dots");
  dotsDir = if lib.hasSuffix "/" dotsDirRaw then lib.substring 0 (lib.stringLength dotsDirRaw - 1) dotsDirRaw else dotsDirRaw;
  dotsDirLen = lib.stringLength dotsDir + 1; # +1 to account for the separating '/'

  # Recursively collect regular files under a directory, skipping .git at descent time
  collectFiles = dir:
    let
      dirPath = builtins.toPath dir;
      entries = builtins.readDir dirPath;
      names = lib.attrNames entries;
    in lib.concatMap (name:
      let
        kind = entries.${name};
        full = dirPath + "/" + name;
      in
        if name == ".git" then
          []                                # skip .git directories entirely
        else if kind == "directory" then
          collectFiles full                 # recurse into directories
        else
          [ { src = builtins.toPath full; relFull = full; } ]
    ) names;

  # Compute relative path from dotsDir (remove prefix safely)
  computeRel = fullPath:
    let
      full = toString fullPath;
      rel = if lib.hasPrefix (dotsDir + "/") full then lib.substring dotsDirLen (lib.stringLength full - dotsDirLen) full else full;
    in rel;

  # Filter out markdown files and top-level .git entries (applies to relative paths)
  dotFilesFiltered = lib.filter (f:
    let rel = computeRel f.src;
    in !lib.hasSuffix ".md" rel && !(lib.hasPrefix ".git" rel)
  ) (collectFiles dotsDir);

  # Build sanitized, unique attribute name for home.file
  toAttr = f:
    let
      rel = computeRel f.src;
      # keep destination exactly as relative path (can start with a dot)
      destination = rel;
      # strip any leading '.' or '/' for attribute name
      relNoLead = if lib.hasPrefix "." rel then lib.substring 1 (lib.stringLength rel - 1) rel else rel;
      relNoLead2 = if lib.hasPrefix "/" relNoLead then lib.substring 1 (lib.stringLength relNoLead - 1) relNoLead else relNoLead;
      baseName = lib.replaceStrings [ "/" ] [ "__" ] relNoLead2;
      shortHash = lib.substring 0 8 (builtins.hashString "sha256" (toString f.src));
      name = if baseName == "" then shortHash else baseName + "-" + shortHash;
    in {
      name = name;
      value = {
        source = f.src;
        destination = destination;
        type = "symlink";
      };
    };

in {
  config.home.file = lib.listToAttrs (map toAttr dotFilesFiltered);

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
