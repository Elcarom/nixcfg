{ pkgs, lib, config, ... }:

{
  environment.systemPackages = [
    pkgs.mediamtx
    pkgs.ffmpeg-full
  ];

  # Declarative v4l2loopback setup — built and loaded automatically at boot
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=2 video_nr=1,2 card_label=cam_main,cam_sub exclusive_caps=1
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
            ${lib.getExe pkgs.ffmpeg-full} -y -hwaccel cuda -hwaccel_output_format cuda \
              -f v4l2 -input_format mjpeg -video_size 1920x1080 -framerate 30 -i /dev/video0 \
              -vf scale_cuda=1920:1080,format=yuv420p -c:v h264_nvenc -b:v 5M -pix_fmt yuv420p \
              -f v4l2 /dev/video1 &

            ${lib.getExe pkgs.ffmpeg-full} -y -hwaccel cuda -hwaccel_output_format cuda \
              -f v4l2 -input_format mjpeg -video_size 1920x1080 -framerate 30 -i /dev/video0 \
              -vf scale_cuda=640:360,format=yuv420p -c:v h264_nvenc -b:v 1M -pix_fmt yuv420p \
              -f v4l2 /dev/video2
          '';
          runOnInitRestart = true;
        };
      };
    };
  };
}
