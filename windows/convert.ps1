$videoDir = ".\videos" # bilibili客户端下载的视频文件夹目录
$skipBytes = 9 # 裁剪的字节数量

Get-ChildItem -Path $videoDir -Recurse -Filter '*.mp4' | ForEach-Object {
  $_.FullName | Remove-Item 
}

# 递归遍历 videos 目录，查找所有 m4s 文件
Get-ChildItem -Path $videoDir -Recurse -Filter '*.m4s' | ForEach-Object {
  $fileName = $_.BaseName
  # 获取当前文件的目录路径
  $currentDirectory = Split-Path -Parent $_.FullName
  
  # 获取 videoInfo.json 文件路径, 获取视频标题
  $infoFile = Join-Path $currentDirectory 'videoInfo.json'
  $videoInfo = Get-Content $infoFile | ConvertFrom-Json
  $title = $videoInfo.title
  $dest = Join-Path $currentDirectory "$title.$fileName.mp4"

  # 删除前 9 个字节，并保存为新文件
  $bytes = [System.IO.File]::ReadAllBytes($_.FullName)
  $newBytes = [System.Linq.Enumerable]::Skip($bytes, $skipBytes).ToArray()
  [System.IO.File]::WriteAllBytes($dest, $newBytes)

  # if ((Get-ChildItem $m4sDir -Filter "*.mp4" | Measure-Object).Count -eq 2) {
  #   $mp4Files = Get-ChildItem $m4sDir -Filter "*.mp4" | Select-Object -ExpandProperty FullName
  #   $outputFile = Join-Path $m4sDir "$title.mp4"
  # }
  # ffmpeg.exe -i 288317891-1-30280.mp4 -i 288317891-1-30064.mp4 -codec copy output.mp4
}