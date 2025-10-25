{ pkgs, lib, config, ... }:

{
  environment.systemPackages = [
    pkgs.mediamtx
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
          runOnInit = "${lib.getExe pkgs.ffmpeg-full} -y -f v4l2 -input_format mjpeg -video_size 1920x1080 -framerate 30 -i /dev/video0 -c:v libx264 -b:v 5M -f rtsp rtsp://localhost:$RTSP_PORT/main -vf scale=640:360 -c:v libx264 -b:v 1M -f rtsp rtsp://localhost:$RTSP_PORT/sub";
        };
      };
    };
  };
}
