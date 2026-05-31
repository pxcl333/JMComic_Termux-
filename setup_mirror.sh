#!/data/data/com.termux/files/usr/bin/bash
# ============================================
# JMComic Termux 自动配置脚本（镜像版）
# 功能：安装依赖、创建快捷命令、配置目录
# 使用国内镜像源（清华、阿里云）
# 使用方法：bash setup_mirror.sh
# ============================================

set -e

echo "=========================================="
echo "  JMComic Termux 自动配置（镜像版）"
echo "=========================================="

# 1. 检查并申请存储权限
echo ""
echo "[1/5] 检查存储权限..."
if [ ! -d "$HOME/storage" ]; then
    echo "⚠️ 未检测到存储权限，正在请求..."
    termux-setup-storage
    echo "✅ 请在手机上点击「允许」，然后按回车继续"
    read -r
else
    echo "✅ 存储权限已就绪"
fi

# 2. 更换 Termux 源为清华源（国内加速）
echo ""
echo "[2/5] 更换 Termux 软件源（清华源）..."
termux-change-repo << EOF
Mirrors in Chinese Mainland
https://mirrors.tuna.tsinghua.edu.cn/termux/apt/termux-main
EOF
pkg update -y

# 3. 安装 Python 依赖（使用清华 PyPI 源）
echo ""
echo "[3/5] 安装 Python 依赖..."
pkg install python -y
pip install jmcomic -U -i https://pypi.tuna.tsinghua.edu.cn/simple
pip install pyyaml pycryptodome -i https://pypi.tuna.tsinghua.edu.cn/simple

# 4. 创建下载目录
echo ""
echo "[4/5] 创建下载目录..."
DOWNLOAD_DIR="/storage/emulated/0/Download/JMComic"
mkdir -p "$DOWNLOAD_DIR"
echo "✅ 下载目录: $DOWNLOAD_DIR"

# 5. 创建 jm 快捷命令
echo ""
echo "[5/5] 创建 jm 快捷命令..."
cat > $PREFIX/bin/jm << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
DEFAULT_DIR="/storage/emulated/0/Download/JMComic"

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "用法: jm [本子号]"
    echo "      jm 123456"
    echo "      jm           # 交互模式"
    exit 0
fi

if [ -n "$1" ]; then
    mkdir -p "$DEFAULT_DIR"
    cd "$DEFAULT_DIR"
    jmcomic "$1"
    exit 0
fi

read -p "本子 ID: " album_id
if [ -z "$album_id" ]; then
    echo "❌ 本子 ID 不能为空"
    exit 1
fi
cd "$DEFAULT_DIR"
jmcomic "$album_id"
EOF

chmod +x $PREFIX/bin/jm
echo "✅ jm 命令已创建"

# 6. 配置文件
echo ""
echo "[6/6] 创建配置文件..."
mkdir -p $HOME/.config/jmcomic
cat > $HOME/.config/jmcomic/config.yml << 'YAML'
dir_rule:
  base_dir: "/storage/emulated/0/Download/JMComic"
  rule: "Bd_{title}"
download:
  threading:
    image: 30
YAML

if ! grep -q "JM_CONFIG_PATH" ~/.bashrc; then
    echo 'export JM_CONFIG_PATH="$HOME/.config/jmcomic/config.yml"' >> ~/.bashrc
fi
source ~/.bashrc
echo "✅ 配置文件已创建"

echo ""
echo "=========================================="
echo "✅ 配置完成！"
echo "=========================================="
echo ""
echo "使用方法："
echo "  jm 123456         # 快速下载"
echo "  jm                # 交互模式"
echo ""
echo "默认下载目录: /storage/emulated/0/Download/JMComic"