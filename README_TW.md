# Antigravity 2.0 中文語言包 & 漢化引擎 (Linux / Windows / macOS)

👉 **[簡體中文版說明文件 (Simplified Chinese README)](README.md)**

> **支援系統**：Linux & Windows & macOS (全平台均內建一鍵指令碼)  
> **匹配版本**：Antigravity v2.12.2+  
> **核心引擎**：Node.js (**內建純 JS 零依賴 ASAR 解包與打包引擎，100% 離線極速執行**)  
> **中文化範圍**：軟體主介面、頂部系統功能表、工作列/系統匣右鍵選單、載入動畫、參數設定面板、新手引導及登入頁。  
> **注入原理**：基於 ASAR 物理層解包與精準重新打包機制，安全注入 `preload.js` 動態翻譯引擎與選單 patch，絕不破壞核心二進位檔案，支援隨時一鍵無痕還原官方原版。  
> **開源說明**：本專案基於優秀開源專案 [qqxpee/antigravity2-cn](https://github.com/qqxpee/antigravity2-cn) 進行深度二次開發與增強，重點打造了 **Linux 平台的原生適配**，並重構內建了 **零依賴純 JS ASAR 引擎**，徹底擺脫原版對 `npx @electron/asar` 及外網下載的依賴。

---

## ✨ Linux 增強版核心特性

- 🐧 **原生 Linux 深度適配**：
  - 自動偵測主流 Linux 發行版（Ubuntu、Debian、Fedora、Arch Linux、openSUSE 等）的各類安裝位置（`~/ProgramFile/Antigravity-x64`、`/opt/Antigravity`、`~/.local/share/antigravity` 等）。
  - 支援透過 `which antigravity`、`.desktop` 桌面捷徑及執行中進程 `/proc/<pid>/exe` 智慧推導安裝路徑。
  - 精準辨識 GUI 進程，關閉用戶端時絕不誤殺後台 `language_server` 語言伺服器。
  - 針對系統級目錄（如 `/opt`）支援智慧 `sudo` 提權檢測。
- ⚡ **內建純 JS 零依賴 ASAR 引擎**：
  - 原版依賴 `npx -y @electron/asar` 連網拉取依賴，在網路受限或代理異常時極易卡死或報錯（如 403 Forbidden）。
  - 本專案內建原生 JavaScript Chromium Pickle / ASAR 引擎，自動計算並填入 4MB 分塊 SHA256 integrity 校驗雜湊，解包與重新打包僅需 **100~200 毫秒**，純離線可用。
- 🖱️ **一鍵雙擊與終端機多模態支援**：
  - 內建 `.sh` 指令碼既可在終端機中直接執行，也支援在 Linux 桌面檔案管理器（GNOME Nautilus、KDE Dolphin、XFCE 等）中直接雙擊自動拉起獨立終端機視窗互動執行。

---

> [!WARNING]
> **關於聊天歷史記錄/對話方塊內容被中文化的已知問題及匹配機制說明（開發者必讀）**：
> - **現象**：當你在聊天或對話方塊中發送了某些與軟體介面 UI 完全相同的英文關鍵詞或句子時，該對話氣泡在介面上可能會被翻譯引擎中文化顯示。
> - **核心匹配機制**：
>   - **短詞（長度 <= 15 字元，如 `Knowledge`）**：翻譯僅在詞條 **完全精準匹配（且個別占一行）** 時觸發。如果該詞前後有其他任何字元、空格或標點符號（如 `Knowledge是什麼`、`哈哈 Knowledge`），則 **絕對不會** 被翻譯。如果需要強行阻止其翻譯，可使用中文雙引號將其包裹（如 `“Knowledge”`）即可完美規避。
>   - **長句（長度 > 15 字元，如 `Enable Antigravity to deploy apps...`）**：由於需要相容介面動態渲染，長句採用 **“子串滑動替換”** 算法。這意味著只要輸入的文字中包含了這一長串完整英文字句，該段子串就會被自動翻譯成中文（即使加了引號或前後帶有文字）。但由於長句匹配極其苛刻，必須一字不差（包括大小寫、標點和空格），因此實際聊天中幾乎不可能誤觸發。
> - **說明**：這**不影響 AI 接收到的原文**。大模型取得的依舊是你發送的純正英文原始指令，僅在軟體的視覺渲染層面發生了中文化，純屬視覺影響，無需擔心影響大模型的效果。

---

## 📸 中文化效果展示

以下是部分功能板塊的實際中文化效果展示，涵蓋登入引導頁、主編輯器介面與詳細設定面板：

### 1. 歡迎頁與登入新手引導
![歡迎頁與登入新手引導](./showimg/showlogin_tw.png)

### 2. 主編輯器介面與選單
![主編輯器介面與選單](./showimg/showmain_tw.png)

### 3. 詳細參數設定面板
![詳細參數設定面板](./showimg/showmenu_tw.png)

---

## 📂 專案檔案結構

```text
├── 双击安装繁体中文.sh          # [Linux] 繁體中文一鍵安裝入口
├── 双击安装中文汉化.sh          # [Linux] 簡體中文一鍵安裝入口
├── 双击卸载还原官方英文.sh      # [Linux] 一鍵卸載恢復官方英文入口
├── 双击安装繁体中文.bat         # [Windows] 繁體中文一鍵安裝
├── 双击安装中文汉化.bat         # [Windows] 簡體中文一鍵安裝
├── 双击卸载还原官方英文.bat     # [Windows] 一鍵卸載恢復
├── 双击安装繁体中文.command     # [macOS] 繁體中文一鍵安裝
├── 双击安装中文汉化.command     # [macOS] 簡體中文一鍵安裝
├── 双击卸载还原官方英文.command # [macOS] 一鍵卸載恢復
├── localization_engine.js      # 核心跨平台中文化引擎 (內建純 JS 零依賴 ASAR 模組)
├── dicts_tw/                   # 繁體中文模組化對照詞典 (JSON)
├── dicts/                      # 簡體中文模組化對照詞典 (JSON)
├── showimg/                    # 介面預覽截圖
├── README.md                   # 簡體中文說明文件
└── README_TW.md                # 繁體中文說明文件
```

---

## 🚀 極速使用指南

### 1. 取得程式碼

* **透過 Git 命令列複製（推薦 💻）**：
  ```bash
  git clone https://github.com/Uspro7/antigravity2-cn-Linux.git
  cd antigravity2-cn-Linux
  ```
  *(若在國內網路受限，可使用鏡像位址：`git clone https://mirror.ghproxy.com/https://github.com/Uspro7/antigravity2-cn-Linux.git`)*

* **或直接下載 ZIP 壓縮包 📦**：
  點擊頁面右上角 **Code -> Download ZIP**，下載後解壓至本機任意目錄。

---

### 2. 一鍵安裝中文化

1. **完全退出** Antigravity 軟體。
2. 執行安裝指令碼：
   - **Linux**：在終端機執行 `./双击安装繁体中文.sh`（或在圖形檔案管理器中直接雙擊執行）。
   - **Windows**：雙擊執行 `双击安装繁体中文.bat`。
   - **macOS**：雙擊執行 `双击安装繁体中文.command`。
3. 依提示選擇左上角品牌名稱顯示方式：
   - **[1] 顯示英文 Antigravity（推薦）**：保留官方英文名稱，排版緊湊。
   - **[2] 不顯示品牌名**：隱藏標題左上角品牌名稱。
   - **[3] 顯示中文品牌名**：顯示為繁體中文品牌名。
4. 執行完成後啟動 Antigravity 軟體，即可暢享全繁體中文介面！

> **需要簡體中文？**
> 執行對應的 `双击安装中文汉化.sh` / `.bat` / `.command` 即可一鍵部署簡體中文。

#### 進階命令列參數

如果您透過終端機呼叫 `localization_engine.js`，可以使用以下參數：

```bash
# 指定安裝目錄 (若未自動偵測到您的自訂路徑)
node localization_engine.js --install-dir /path/to/Antigravity

# 控制品牌名稱模式：english(預設) | hidden | translated
node localization_engine.js --tw --brand-title english

# 簡體中文模式 (預設為簡體，加 --tw 啟用繁體)
node localization_engine.js

# 跳過自動關閉執行中用戶端
node localization_engine.js --no-kill

# 一鍵卸載恢復官方原版
node localization_engine.js --huifu
```

---

### 3. 一鍵卸載還原

若需要升級軟體或還原至官方純淨英文版：
1. 完全退出 Antigravity。
2. 執行卸載指令碼：
   - **Linux**：執行 `./双击卸载还原官方英文.sh`
   - **Windows**：執行 `双击卸载还原官方英文.bat`
   - **macOS**：執行 `双击卸载还原官方英文.command`
3. 指令碼會自動使用安裝時備份的 `app.asar.bak` 無痕還原，並自動清理相關應用快取。

---

## 🔌 可選進階功能：網路透明代理自動注入 (Windows 免 TUN 方案)

如果您處於網路受限環境（例如連線 Google AI / Gemini API 遇到限制），且不想開啟虛擬網卡/全域 TUN 模式，本專案在 Windows 下支援在安裝中文化時**自動聯動注入免 TUN 強制代理工具**。

該代理方案基於開源專案 **[yuaotian/antigravity-proxy](https://github.com/yuaotian/antigravity-proxy)**（基於 MinHook 的 DLL 劫持透明代理）。

### 使用方法：
1. 前往 **[yuaotian/antigravity-proxy](https://github.com/yuaotian/antigravity-proxy)** 下載編譯好的檔案：
   - `version.dll`、`dbghelp.dll`、`config.json`
2. 在當前中文化專案根目錄新增 `proxy_config` 資料夾（已設定 `.gitignore`，不會被 Git 提交）。
3. 將上述檔案依本機代理連接埠配置好後放入 `proxy_config/` 目錄。
4. 正常執行 `双击安装繁体中文.bat`，引擎將**自動偵測並一次性完成中文化與代理模組注入**。

---

## 🛠️ 中文化原理說明

本引擎專為 **Antigravity 2.0+** 的 Electron 架構量身打造：
1. **自動釋放鎖**：執行前智慧偵測並安全關閉主介面進程，防止檔案鎖定佔用。
2. **安全備份**：首次執行時自動建立 `app.asar.bak` 原始包備份，確保隨時可無失真一鍵復原。
3. **精準注入**：
   - `preload.js`：採用 WeakSet 記錄與 Shadow DOM 穿透，啟動高效的 `MutationObserver` 引擎，動態監測並將渲染層文字翻譯為中文。
   - `menu.js`：深度修補系統原生頂部選單。
   - `tray.js`：中文化工作列系統匣與右鍵通知狀態選單。
   - `loadingOverlay.js`：注入趣味載入動畫提示文案。
   - `updater.js`：中文化更新提示彈出視窗。
4. **重新打包與校驗**：內建 ASAR 打包器重新封裝，計算 SHA256 integrity 保證 Electron 完整性驗證通過，並自動清理舊位元組碼快取。

---

## 💡 如何透過 AI 助手自動補充或修改中文化？

在使用過程中若發現漏譯或未翻譯的英文，**您可以直接在 Antigravity 聊天視窗中讓 AI 助手幫您補充詞典**！

> [!TIP]
> **最佳實踐**：在 Antigravity 中點擊 **“開啟資料夾 (Open Folder)”**，直接將本專案目錄作為**專案/工作區**開啟，在當前視窗中向 AI 發送截圖或文字即可！
> - **截圖提示詞**：> *“幫我把這張截圖裡所有未翻譯的英文選項和面板內容補全到繁體中文詞典中。”*
> - **文字提示詞**：> *“幫我把漏譯的英文 'Allow agent to view and edit files outside workspace' 翻譯為 '允許代理編輯工作區外的檔案'。”*
>
> 詞典修改儲存後，只需重新執行一次安裝指令碼即可立即生效！

---

## ❓ 常見問題解答 (FAQ)

### 1）Linux 提示 Permission denied 或權限不足
* **解決**：賦予指令碼執行權限：
  ```bash
  chmod +x *.sh
  ```
  如果您的 Antigravity 安裝在 `/opt` 或 `/usr` 等系統目錄，請使用管理員權限執行：
  ```bash
  sudo ./双击安装繁体中文.sh
  ```

### 2）Linux 未能自動找到 Antigravity 安裝路徑
* **解決**：可以使用 `--install-dir` 手動指定安裝路徑，例如：
  ```bash
  node localization_engine.js --install-dir /home/你的使用者名稱/ProgramFile/Antigravity-x64
  ```
  也可以設定環境變數：
  ```bash
  export ANTIGRAVITY_INSTALL_DIR="/home/你的使用者名稱/ProgramFile/Antigravity-x64"
  ./双击安装繁体中文.sh
  ```

### 3）macOS 提示“無法打開”或權限問題
* **解決**：在終端機中執行 `chmod +x *.command`。本引擎已內建自動本機 Ad-hoc 深度重新簽名機制 (`codesign`)，自動消除修改後的系統安全攔截警告。

### 4）軟體官方版本更新後中文化失效了怎麼辦？
* 軟體官方升級會覆蓋 `app.asar` 檔案。只需完全退出軟體，重新執行一次安裝指令碼即可重新部署中文化！

---

## 🤝 致謝與聲明

- 核心字典與基礎邏輯致謝上游專案：**[qqxpee/antigravity2-cn](https://github.com/qqxpee/antigravity2-cn)**
- Windows 透明代理方案致謝：**[yuaotian/antigravity-proxy](https://github.com/yuaotian/antigravity-proxy)**
- 歡迎提交 Issue 與 PR 共同完善全平台中文生態！
