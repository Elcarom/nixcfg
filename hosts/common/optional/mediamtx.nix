{ pkgs, lib, ... }:
{
  environment.systemPackages = [
    pkgs.mediamtx
  ];

  services.mediamtx = {
    enable = true;
    allowVideoAccess = true;

    settings = {
      paths = {
        cam = {
          runOnInit = ''
            ${lib.getExe pkgs.ffmpeg-full} -y \
              -hwaccel cuda -hwaccel_output_format cuda \
              -f v4l2 -input_format mjpeg -video_size 1920x1080 -framerate 30 \
              -i /dev/video0 \
              -filter_complex "[0:v]split=2[v1][v2];[v1]scale_cuda=1920:1080[vout1];[v2]scale_cuda=640:360[vout2]" \
              -map "[vout1]" -c:v h264_nvenc -b:v 5M -f rtsp rtsp://localhost:8554/main \
              -map "[vout2]" -c:v h264_nvenc -b:v 2M -f rtsp rtsp://localhost:8554/sub
          '';
          runOnInitRestart = true;
        };
      };
    };
  };
}
