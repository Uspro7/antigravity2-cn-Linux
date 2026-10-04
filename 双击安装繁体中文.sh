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
    echo " 錯誤：系統未檢測到 Node.js 環境！"
    echo " 請先在系統安裝 Node.js (推薦 v18+)，例如："
    echo "   Ubuntu/Debian: sudo apt install nodejs"
    echo "   Fedora/RHEL:   sudo dnf install nodejs"
    echo "   Arch Linux:    sudo pacman -S nodejs"
    echo "======================================================"
    read -n 1 -s -p "按任意鍵結束..."
    echo ""
    exit 1
fi

echo "====== 正在安裝 Linux 版 Antigravity 繁體中文漢化 ======"
echo "請選擇左上角品牌顯示方式："
echo "[1] 顯示英文 Antigravity（推薦）"
echo "[2] 不顯示品牌名"
echo "[3] 顯示中文品牌名"
printf "請輸入 1/2/3，直接回車預設 1："
read -r BRAND_CHOICE
BRAND_ARG="--brand-title english"
if [ "$BRAND_CHOICE" = "2" ]; then
    BRAND_ARG="--brand-title hidden"
elif [ "$BRAND_CHOICE" = "3" ]; then
    BRAND_ARG="--brand-title translated"
fi

node localization_engine.js --tw $BRAND_ARG "$@"
EXIT_CODE=$?

if [ $EXIT_CODE -ne 0 ]; then
    echo ""
    echo "執行失敗！請檢查上方錯誤訊息。"
    read -n 1 -s -p "按任意鍵結束..."
    echo ""
    exit 1
fi

echo ""
echo "處理完成。視窗將在 5 秒後自動關閉（或按任意鍵立即關閉）..."
read -t 5 -n 1 -s || true
