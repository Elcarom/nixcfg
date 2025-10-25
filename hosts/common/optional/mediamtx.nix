{ pkgs, lib, ... }:
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
        cam = {
          runOnInit = "${lib.getExe pkgs.ffmpeg} -y -hwaccel cuda -hwaccel_output_format cuda -f v4l2 -input_format mjpeg -video_size 1920x1080 -framerate 30 -i /dev/video0 -filter_complex "[0:v]split=2[main][sub]; [main]scale_cuda=1920:1080,format=yuv420p[mainout]; [sub]scale_cuda=640:360,format=yuv420p[subout]" -map "[mainout]" -c:v h264_nvenc -b:v 5M -pix_fmt yuv420p -f rtsp rtsp://localhost:$RTSP_PORT/main -map "[subout]" -c:v h264_nvenc -b:v 1M -pix_fmt yuv420p -f rtsp rtsp://localhost:$RTSP_PORT/sub";
          runOnInitRestart = true;
        };
        all_others = {
          runOnInitRestart = true;
        };
      };
    };
  };
}
