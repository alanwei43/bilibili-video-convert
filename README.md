# Bilibili 视频转换

## 准备工作

将bilibi客户端下载的视频文件放在 `videos` 根目录下, 结构如下:

```
- videos
  - 288318938
    - 288318938-1-30064.m4s
    - 288318938-1-30280.m4s
    - videoInfo.json
  - 288320627
    - 288320627-1-30024.m4s
    - 288320627-1-30200.m4s
    - videoInfo.json
  - ...
```

## 执行转换

在项目根目录打开终端, 根据不同环境执行操作：

### Windows

Windows 环境打开终端执行 `convert.ps1` 文件转换视频:

```powershell
.\windows\convert.ps1
```

### Linux

```bash
# 安装依赖
sudo apt-get install jq ffmpeg -y

# 执行转换
./linux/convert.sh
```