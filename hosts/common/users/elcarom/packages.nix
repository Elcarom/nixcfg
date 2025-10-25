{pkgs, ...}: {
  users.users.elcarom.packages = with pkgs; [
    brave
    steam
    vlc
  ];
}
