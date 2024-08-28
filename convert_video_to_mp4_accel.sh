ffmpeg -hwaccel vaapi -hwaccel_output_format vaapi -vaapi_device /dev/dri/renderD128 -i "$1" -codec:v h264_vaapi -vf scale_vaapi=w=1280:h=720,setsar=1:1 "$2"
