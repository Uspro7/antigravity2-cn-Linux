#!/usr/bin/env bash

# 如果从图形文件管理器双击启动（未连接终端且存在显示环境），尝试拉起独立终端窗口运行
if [ -z "$TERM_SPAWNED" ] && [ -n "$DISPLAY$WAYLAND_DISPLAY" ]; then
    if [ ! -t 0 ] && [ ! -t 1 ]; then
        export TERM_SPAWNED=1
        for term in gnome-terminal konsole xfce4-terminal alacritty kitty foot xterm x-terminal-emulator; do
            if command -v "$term" >/dev/null 2>&1; then
                case "$term" in
                    gnome-terminal|xfce4-terminal)
                        exec "$term" -- bash "$0" "$@"
                        ;;
                    konsole)
                        exec "$term" -e bash "$0" "$@"
                        ;;
                    *)
                        exec "$term" -e "$0" "$@"
                        ;;
                esac
            fi
        done
    fi
fi

cd "$(dirname "$0")"

# 检查 Node.js 环境
if ! command -v node >/dev/null 2>&1; then
    echo "======================================================"
    echo " 错误：系统未检测到 Node.js 环境！"
    echo " 请先在系统安装 Node.js (推荐 v18+)，例如："
    echo "   Ubuntu/Debian: sudo apt install nodejs"
    echo "   Fedora/RHEL:   sudo dnf install nodejs"
    echo "   Arch Linux:    sudo pacman -S nodejs"
    echo "======================================================"
    read -n 1 -s -p "按任意键退出..."
    echo ""
    exit 1
fi

echo "====== 正在安装 Linux 版 Antigravity 中文汉化 ======"
echo "请选择左上角品牌显示方式："
echo "[1] 显示英文 Antigravity（推荐）"
echo "[2] 不显示品牌名"
echo "[3] 显示中文品牌名"
printf "请输入 1/2/3，直接回车默认 1："
read -r BRAND_CHOICE
BRAND_ARG="--brand-title english"
if [ "$BRAND_CHOICE" = "2" ]; then
    BRAND_ARG="--brand-title hidden"
elif [ "$BRAND_CHOICE" = "3" ]; then
    BRAND_ARG="--brand-title translated"
fi

node localization_engine.js $BRAND_ARG "$@"
EXIT_CODE=$?

if [ $EXIT_CODE -ne 0 ]; then
    echo ""
    echo "运行失败！请检查上方错误信息。"
    read -n 1 -s -p "按任意键退出..."
    echo ""
    exit 1
fi

echo ""
echo "处理完成。窗口将在 5 秒后自动关闭（或按任意键立即关闭）..."
read -t 5 -n 1 -s || true
