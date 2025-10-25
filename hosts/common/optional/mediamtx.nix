{ pkgs, lib, config, ... }:

{
  environment.systemPackages = [
    pkgs.mediamtx
    pkgs.ffmpeg-full
    pkgs.v4l-utils
  ];

  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = [ pkgs.linuxPackages_latest.v4l2loopback ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=2 video_nr=1,2 card_label=cam_main,cam_sub exclusive_caps=1
  '';

  services.udev.extraRules = ''
    SUBSYSTEM=="video4linux", ATTR{name}=="cam_main", SYMLINK+="v4l/by-id/video-cam_main"
    SUBSYSTEM=="video4linux", ATTR{name}=="cam_sub",  SYMLINK+="v4l/by-id/video-cam_sub"
  '';

  services.mediamtx = {
    enable = true;
    allowVideoAccess = true;

    settings = {
      paths = {
        all_others = {
          runOnInitRestart = true;
        };
        cam = {
          runOnInit = ''
            ${lib.getExe pkgs.ffmpeg-full} -y \
              -hwaccel cuda -hwaccel_output_format cuda \
              -f v4l2 -input_format mjpeg -video_size 1920x1080 -framerate 30 -i /dev/video0 \
              -vf "scale_cuda=1920:1080" \
              -c:v h264_nvenc -b:v 5M \
              -f v4l2 /dev/v4l/by-id/video-cam_main &

            ${lib.getExe pkgs.ffmpeg-full} -y \
              -hwaccel cuda -hwaccel_output_format cuda \
              -f v4l2 -input_format mjpeg -video_size 1920x1080 -framerate 30 -i /dev/video0 \
              -vf "scale_cuda=640:360" \
              -c:v h264_nvenc -b:v 1M \
              -f v4l2 /dev/v4l/by-id/video-cam_sub &
          '';
        };
      };
    };
  };
}
