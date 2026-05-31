```markdown
# JMComic_Termux

JMComic 在 Termux 上的安装与配置指南

## 前置要求

- 安装 **Termux**（推荐从 [F-Droid](https://f-droid.org/）下载）
- 安装 **Termux:API**（同样从 F-Droid 下载）
- 首次打开 Termux 后，建议先运行 `pkg update && pkg upgrade -y`

## 一键配置（推荐）

在 Termux 中复制并执行以下命令：

bash <(curl -s https://raw.githubusercontent.com/pxcl333/JMComic_Termux-/main/setup.sh) && \
wget -P ~/storage/downloads/ "https://github.com/hect0x7/JMComic-APK/releases/download/2.0.24/2.0.24.apk" && \
echo "✅ 完成"

## 国内镜像源配置
bash <(curl -s https://raw.githubusercontent.com/pxcl333/JMComic_Termux-/main/setup_mirror.sh) && \
wget -P ~/storage/downloads/ "https://github.com/hect0x7/JMComic-APK/releases/download/2.0.24/2.0.24.apk" && \
echo "✅ 完成"
```


执行完成后：

1. 打开手机文件管理器，进入 Download 文件夹
2. 点击 2.0.24.apk 安装
3. 在 Termux 中输入 jm 123456 测试下载

如果提示「禁止安装未知来源应用」，请前往：手机设置 → 安全 → 安装未知应用 → 授权你的文件管理器。

手动下载 APK（备选）

如果上面的 wget 命令下载失败，可以手动下载：

1. 用浏览器打开 JMComic-APK Releases
2. 下载最新版本的 .apk 文件
3. 安装到手机


手动安装（备选）

如果一键配置失败，可以按以下步骤手动操作：

1. 安装依赖

```bash
pkg update -y
pkg install python -y
pip install jmcomic -i https://pypi.tuna.tsinghua.edu.cn/simple
```

2. 创建下载目录

```bash
mkdir -p /storage/emulated/0/Download/JMComic
```

3. 创建 jm 快捷命令

```bash
cat > $PREFIX/bin/jm << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
DEFAULT_DIR="/storage/emulated/0/Download/JMComic"
[ -n "$1" ] && { mkdir -p "$DEFAULT_DIR"; cd "$DEFAULT_DIR"; jmcomic "$1"; exit 0; }
read -p "本子 ID: " id
cd "$DEFAULT_DIR"
jmcomic "$id"
EOF
chmod +x $PREFIX/bin/jm
```

4. 配置文件（可选）

如需自定义下载规则，创建 ~/.config/jmcomic/config.yml：

```bash
mkdir -p ~/.config/jmcomic
cat > ~/.config/jmcomic/config.yml << 'YAML'
dir_rule:
  base_dir: "/storage/emulated/0/Download/JMComic"
  rule: "Bd_{title}"
download:
  threading:
    image: 30
YAML
```

使用方法

配置完成后，在 Termux 中输入：

```bash
jm 123456
```

将 123456 替换为实际的漫画本子 ID。

🙏 致谢

本工具基于 jmcomic 开源项目，感谢原作者 hect0x7 的开发与分享。


