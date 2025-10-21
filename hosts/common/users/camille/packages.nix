{pkgs, ...}: {
  
  users.users.camille.packages = with pkgs; [
    google-chrome
  ];
}