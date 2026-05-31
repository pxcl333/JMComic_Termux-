# JMComic_Termux

JMComic 在 Termux 上的安装与配置指南

## 📋 前置要求

- 安装 **Termux**（推荐从 [F-Droid](https://f-droid.org/）下载）
- 安装 **Termux:API**（同样从 F-Droid 下载）
- 首次打开 Termux 后，建议先运行 `pkg update && pkg upgrade -y`

## 🚀 一键配置

在 Termux 中复制并执行以下命令：

```bash
bash <(curl -s https://raw.githubusercontent.com/pxcl333/JMComic_Termux/main/setup.sh) && \
wget -P ~/storage/downloads/ "https://github.com/hect0x7/JMComic-APK/releases/download/2.0.24/2.0.24.apk" && \
echo "✅ 环境配置完成，APK 已下载到 Download 文件夹"# JMComic_Termux-
JMComic 在 Termux 上的安装与配置指南
