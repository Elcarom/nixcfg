{ pkgs, lib, config, ... }:

{
  environment.systemPackages = [
    pkgs.stable.mediamtx
    pkgs.ffmpeg-full
  ];

  services.mediamtx = {
    enable = true;
    allowVideoAccess = true;
    settings = {
      paths = {
        all_others = {
          runOnInitRestart = true;
        };
        cam = {
          runOnInit = "${lib.getExe pkgs.ffmpeg-full} -y -hwaccel cuda -hwaccel_output_format cuda -f v4l2 -input_format mjpeg -video_size 1920x1080 -framerate 30 -i /dev/video0 -vf scale_cuda=1920:1080 -c:v h264_nvenc -b:v 5M -f rtsp rtsp://localhost:$RTSP_PORT/main -vf scale_cuda=640:360 -c:v h264_nvenc -b:v 1M -f rtsp rtsp://localhost:$RTSP_PORT/sub";
        };
      };
    };
  };
}
