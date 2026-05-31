# JMComic_Termux

JMComic Installation and Configuration Guide on Termux (for Android phones/tablets)

For learning and technical research purposes only. Please use responsibly.

## Supported Devices

- Android phone or tablet
- Termux and Termux:API installed (see prerequisites below)

## Prerequisites
## About the Download Method

This tutorial uses JMComic as an example to demonstrate a general approach for downloading resources in Termux using Python dependencies + custom shortcut commands.

If you need to download other types of online resources, you may consider:
- Finding corresponding open-source download tools
- Referring to the script structure in this tutorial to write your own shortcut commands

Please evaluate the legality of the content you download. This tutorial does not encourage any form of copyright infringement.
### 1. Install Termux and Termux:API

- Download and install from F-Droid:
  - Termux
  - Termux:API
- Note: Do NOT install from Google Play, as older versions will cause command failures.

### 2. After first opening Termux, you must run:
```
termux-setup-storage
```
A permission popup will appear, tap "Allow".

### 3. Update packages
```
pkg update && pkg upgrade -y
```
## One-Click Setup

Run the following commands in Termux in order:

### Step 1: Install Python dependencies
```
pkg install python -y
pip install jmcomic -U
mkdir -p /storage/emulated/0/Download/JMComic
```
### Step 2: Download JMComic APK
```
download path(example)
 "https://github.com/hect0x7/JMComic-APK/releases/download/2.0.24/2.0.24.apk"
```
### Step 3: Create shortcut command "jm"
```
cat > $PREFIX/bin/jm << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
DEFAULT_DIR="/storage/emulated/0/Download/JMComic"

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage: jm [album_id]"
    echo "      jm 123456       # quick download"
    echo "      jm              # interactive mode"
    exit 0
fi

if [ -n "$1" ]; then
    mkdir -p "$DEFAULT_DIR"
    cd "$DEFAULT_DIR"
    jmcomic "$1"
    exit 0
fi

read -p "Album ID: " id
cd "$DEFAULT_DIR"
jmcomic "$id"
EOF

chmod +x $PREFIX/bin/jm
```
### Step 4: Install APK

Open your phone's file manager, go to the Download folder, and tap 2.0.24.apk to install.

Note: If you see "Install blocked" warning, go to Settings -> Security -> Install unknown apps -> grant permission to your file manager.

## Usage
```
jm 123456
```
Replace 123456 with the actual comic album ID.

## Manual Installation (Alternative)

If one-click setup fails, follow these steps manually:

### 1. Install Python
```
pkg install python -y
```
### 2. Install jmcomic
```
pip install jmcomic -U
```
### 3. Create download directory
```
mkdir -p /storage/emulated/0/Download/JMComic
```
### 4. Download APK
```
wget -P ~/storage/downloads/ "https://github.com/hect0x7/JMComic-APK/releases/download/2.0.24/2.0.24.apk"
```
### 5. Create shortcut command (same as Step 3 above)

## Acknowledgments

This tool is based on the jmcomic open-source project. Thanks to the original author hect0x7 for development and sharing.
Project URL: https://github.com/hect0x7/JMComic-APK

## FAQ

Q: pip install says "command not found"

A: Run pkg install python -y first to install Python.

Q: wget download is slow or fails

A: Network issue. You can try again later, or download manually with a browser:
   https://github.com/hect0x7/JMComic-APK/releases

Q: termux-setup-storage already run but /storage directory not found

A: Close Termux and reopen, or restart your phone.

Q: jm command not found

A: Make sure you ran the cat command block to create the shortcut and ran chmod +x $PREFIX/bin/jm.

Q: jm 123456 download fails

A: Possible reasons:
   - Album ID does not exist
   - Network issue, try switching Wi-Fi or using mobile data
   - jmcomic version is outdated, run pip install jmcomic -U to upgrade

## Disclaimer

- This tool is for learning and technical research only. Do not use for illegal purposes.
- Use the download feature reasonably. Do not mass download resources to avoid putting pressure on target websites.
- Comply with relevant laws and regulations. Respect content copyright.
- Users assume all consequences. This project provides technical solutions only.

## JMComic 在 Termux 上的安装与配置指南（适用于 Android 手机/平板）
## 仅用于学习和提供额外的方法，请合理使用
## 适用设备

- Android 手机或平板
- 已安装 Termux 和 Termux:API（见下方前置要求）
## 关于下载方式

本教程以 JMComic 为例，演示了在 Termux 中通过 Python 依赖 + 快捷命令下载资源的通用思路。

如果你需要下载其他类型的网络资源，可以尝试：
- 寻找对应的开源下载工具
- 参考本教程的脚本结构，自行编写快捷命令

请自行判断所下载内容的合规性，本教程不鼓励任何侵权行为。
## 前置要求

### 1. 安装 Termux 和 Termux:API

- 从 F-Droid 应用商店下载安装：
  - Termux
  - Termux:API
- 注意：不要从 Google Play 下载，版本过旧会导致命令无法执行。

### 2. 首次打开 Termux 后，必须先执行：
```
termux-setup-storage
```
手机会弹出权限请求，点击「允许」。

### 3. 更新软件包
```
pkg update && pkg upgrade -y
```
### 4. 配置国内镜像源（国内用户必须做）

执行以下命令，在菜单中选择镜像源：
```
termux-change-repo
```
操作步骤：
- 选择 Mirrors in Chinese Mainland
- 选择 https://mirrors.tuna.tsinghua.edu.cn/termux/apt/termux-main
- 按回车确认

然后重新更新：
```
pkg update
```
## 一键配置

在 Termux 中依次执行以下命令：

### 第一步：安装 Python 依赖
```
pkg install python -y
pip install jmcomic -U -i https://pypi.tuna.tsinghua.edu.cn/simple
mkdir -p /storage/emulated/0/Download/JMComic
```
### 第二步：下载 JMComic APK
```
其中的示例网址 "https://ghproxy.com/https://github.com/hect0x7/JMComic-APK/releases/download/2.0.24/2.0.24.apk"
```
如果 ghproxy.com 失效，可换成以下任一镜像：
- https://ghproxy.net/
- https://mirror.ghproxy.com/

### 第三步：创建快捷命令 jm
```
cat > $PREFIX/bin/jm << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
DEFAULT_DIR="/storage/emulated/0/Download/JMComic"

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "用法: jm [本子号]"
    echo "      jm 123456       # 快速下载"
    echo "      jm              # 交互模式"
    exit 0
fi

if [ -n "$1" ]; then
    mkdir -p "$DEFAULT_DIR"
    cd "$DEFAULT_DIR"
    jmcomic "$1"
    exit 0
fi

read -p "本子 ID: " id
cd "$DEFAULT_DIR"
jmcomic "$id"
EOF

chmod +x $PREFIX/bin/jm
```
### 第四步：安装 APK

打开手机文件管理器，进入 Download 文件夹，点击 2.0.24.apk 安装。

注意：如果提示「禁止安装未知来源应用」，请前往：手机设置 -> 安全 -> 安装未知应用 -> 授权你的文件管理器。

## 使用方法
```
jm 123456
```
将 123456 替换为实际的漫画本子 ID。

## 手动安装（备选）

如果一键配置失败，可以分步手动执行：

### 1. 安装 Python
```
pkg install python -y
```
### 2. 安装 jmcomic
```
pip install jmcomic -i https://pypi.tuna.tsinghua.edu.cn/simple
```
### 3. 创建下载目录
```
mkdir -p /storage/emulated/0/Download/JMComic
```
### 4. 下载 APK
```
wget -P ~/storage/downloads/ "https://ghproxy.com/https://github.com/hect0x7/JMComic-APK/releases/download/2.0.24/2.0.24.apk"
```
### 5. 创建快捷命令（同上第三步）

## 致谢

本工具基于 jmcomic 开源项目，感谢原作者 hect0x7 的开发与分享。
项目地址：https://github.com/hect0x7/JMComic-APK

## 常见问题

Q: 执行 pip install 时提示 command not found

A: 先执行 pkg install python -y 安装 Python。

Q: wget 下载 APK 很慢或失败

A: 网络问题，可以换一个镜像源，或者用手机浏览器手动下载：
   https://github.com/hect0x7/JMComic-APK/releases

Q: termux-setup-storage 已经执行过，但 /storage 目录不存在

A: 关闭 Termux 重新打开，或重启手机后再试。

Q: 输入 jm 提示找不到命令

A: 检查是否已执行创建快捷命令的 cat 代码块，并确保已执行 chmod +x $PREFIX/bin/jm。

Q: jm 123456 下载失败

A: 可能原因：
   - 本子 ID 不存在
   - 网络问题，可尝试切换 Wi-Fi 或使用手机流量
   - jmcomic 版本过旧，执行 pip install jmcomic -U 升级
## 注意事项

- 本工具仅供学习和技术研究使用，请勿用于非法用途。
- 请合理使用下载功能，不要大量爬取资源，避免对目标网站造成压力。
- 遵守相关法律法规，尊重内容版权。
- 使用者自行承担一切后果，本项目仅提供技术方案。
- 请勿批量下载或用于任何商业用途。