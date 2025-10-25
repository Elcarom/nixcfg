{ pkgs, lib, config, ... }:

{
   environment.systemPackages = [
    pkgs.mediamtx
    pkgs.ffmpeg-full
    pkgs.v4l-utils
  ];

  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = [ pkgs.linuxPackages_latest.v4l2loopback ];
  boot.extraModprobeConfig = '' options v4l2loopback devices=2 video_nr=1,2 card_label=cam_main,cam_sub exclusive_caps=1 '';

  services.udev.extraRules = ''
    SUBSYSTEM=="video4linux", ATTR{name}=="cam_main", SYMLINK+="v4l/by-id/video-cam_main"
    SUBSYSTEM=="video4linux", ATTR{name}=="cam_sub",  SYMLINK+="v4l/by-id/video-cam_sub"
  '';
}
