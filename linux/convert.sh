#!/bin/bash

# 视频文件夹目录
video_dir="./videos"
skip_bytes=9

# 删除所有 .mp4 文件
find "$video_dir" -name '*.mp4' -delete

# 遍历所有 .m4s 文件
for m4s_file in "$video_dir"/**/*.m4s; do
    # 获取文件名、目录和 videoInfo.json 路径
    file_name=$(basename "$m4s_file" .m4s)
    dir_name=$(dirname "$m4s_file")
    info_file="$dir_name/videoInfo.json"

    # 获取视频标题
    video_title=$(jq -r '.title' "$info_file")
    dest_file="$dir_name/$file_name.mp4"

    # 裁剪并保存
    tail -c +$((skip_bytes+1)) "$m4s_file" > "$dest_file"

    mp4_files=("$dir_name"/*.mp4)
    if [ ${#mp4_files[@]} -eq 2 ]; then
        output_file="$dir_name/${video_title}.mp4"
        ffmpeg -i $mp4_files -codec copy "$output_file"
    fi
done