{ config, lib, pkgs, dotfilesPath, ... }:

let
  users = builtins.filter (u: config.users.users.${u}.isNormalUser or false)
           (builtins.attrNames config.users.users);

  # Get list of files/folders inside .config and .local in the dotfiles repo
  configItems = builtins.attrNames (builtins.readDir "${dotfilesPath}/dots/.config");
  localItems  = builtins.attrNames (builtins.readDir "${dotfilesPath}/dots/.local");

  makeRulesForUser = user:
    let
      home = config.users.users.${user}.home or "/home/${user}";

      cfgLinks = map (item:
        "L ${home}/.config/${item} - - - - ${dotfilesPath}/dots/.config/${item}"
      ) configItems;

      localLinks = map (item:
        "L ${home}/.local/${item} - - - - ${dotfilesPath}/dots/.local/${item}"
      ) localItems;

    in [
      "d ${home}/.config 0755 ${user} users -"
      "d ${home}/.local 0755 ${user} users -"
    ] ++ cfgLinks ++ localLinks;

  tmpfilesRules = lib.flatten (map makeRulesForUser users);

in {
  systemd.tmpfiles.rules = tmpfilesRules;

  environment.etc."dotfiles".source = dotfilesPath;

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
    glib # for `gsettings` it seems?
    #   nm-connection-editor
    quickshell
    swww
    translate-shell
    wlogout
    
    ];
}
