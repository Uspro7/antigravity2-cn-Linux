# Antigravity 2.0 Linux 中文語言包 & 漢化引擎

👉 **[簡體中文版說明文件 (Simplified Chinese README)](README.md)**

> [!IMPORTANT]
> **關於上游專案與本專案定位**：  
> 本專案的上游倉庫為 **[qqxpee/antigravity2-cn](https://github.com/qqxpee/antigravity2-cn)**。上游原版主要面向 Windows 與 macOS 平台，**我們只做了 Linux 平台的適配工作**（包括 Linux 目錄偵測、Linux 進程管理與內建零依賴純 JS ASAR 引擎）。中文化詞庫與基礎注入邏輯均來自於上游倉庫。如果您使用的是 Windows 或 macOS，請直接前往上游倉庫取得對應版本。

> **支援系統**：Linux (Ubuntu / Debian / Fedora / Arch Linux / openSUSE / Deepin / Manjaro 等所有主流發行版)  
> **匹配版本**：Antigravity v2.12.2+  
> **核心引擎**：Node.js (**內建純 JS 零依賴 ASAR 解包與打包引擎，100% 離線極速執行**)  
> **中文化範圍**：軟體介面、頂部系統功能表、工作列系統匣右鍵選單、載入動畫、參數設定面板、新手引導及登入頁。  
> **注入原理**：基於 ASAR 物理層解包與精準重新打包機制，安全注入 `preload.js` 動態翻譯機制，絕不修改核心二進位檔案，支援一鍵無痕還原官方英文原版。

---

## ✨ Linux 核心特性

- 🐧 **Linux 深度適配與智慧路徑偵測**：
  - 自動辨識使用者層級常見目錄：`~/ProgramFile/Antigravity-x64`、`~/ProgramFile/Antigravity`、`~/Programs/Antigravity`、`~/.local/share/antigravity` 等。
  - 自動辨識系統級安裝目錄：`/opt/Antigravity`、`/opt/Antigravity-x64`、`/usr/share/antigravity` 等。
  - 自動透過 `which antigravity` 及系統 `.desktop` 桌面捷徑解析真實安裝路徑。
  - 支援透過 `/proc/<pid>/exe` 反查目前執行中的用戶端路徑。
- ⚡ **內建純 JS 零依賴 ASAR 引擎**：
  - 無需連網，無需安裝額外 npm 套件，無需設定 npm 代理。
  - 內建原生 JavaScript Chromium Pickle / ASAR 引擎，自動計算並填入 4MB 分塊 SHA256 integrity 完整性校驗雜湊。
  - 解包與打包僅需 **100~200 毫秒**，極速且 100% 離線穩定。
- 🛡️ **進程安全管理與權限提權**：
  - 精準辨識 GUI 主進程，關閉用戶端時絕不誤殺後台 `language_server` 語言伺服器。
  - 當 Antigravity 安裝在系統目錄（如 `/opt`）且目前使用者無寫入權限時，自動觸發 `sudo` 提權或給出清楚提示。
- 🖱️ **終端機與圖形桌面雙模態支援**：
  - 指令碼既可在終端機中直接執行，也支援在 Linux 桌面檔案管理器（GNOME Nautilus、KDE Dolphin、XFCE 等）中直接雙擊自動拉起獨立終端機視窗互動執行。

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

涵蓋登入引導頁、主編輯器介面與詳細設定面板：

### 1. 歡迎頁與登入新手引導
![歡迎頁與登入新手引導](./showimg/showlogin_tw.png)

### 2. 主編輯器介面與選單
![主編輯器介面與選單](./showimg/showmain_tw.png)

### 3. 詳細參數設定面板
![詳細參數設定面板](./showimg/showmenu_tw.png)

---

## 📂 專案檔案結構

```text
├── 双击安装繁体中文.sh          # Linux 繁體中文一鍵安裝入口
├── 双击安装中文汉化.sh          # Linux 簡體中文一鍵安裝入口
├── 双击卸载还原官方英文.sh      # Linux 一鍵卸載恢復官方英文入口
├── localization_engine.js      # 核心中文化引擎 (內建純 JS 零依賴 ASAR 模組)
├── dicts_tw/                   # 繁體中文模組化對照詞典 (JSON)
├── dicts/                      # 簡體中文模組化對照詞典 (JSON)
├── showimg/                    # 介面預覽截圖
├── README.md                   # 簡體中文說明文件
└── README_TW.md                # 繁體中文說明文件
```

---

## 🚀 極速使用指南

### 1. 取得專案程式碼

* **使用 Git 複製（推薦 💻）**：
  ```bash
  git clone https://github.com/Uspro7/antigravity2-cn-Linux.git
  cd antigravity2-cn-Linux
  ```
  *(國內網路受限可使用加速位址：`git clone https://mirror.ghproxy.com/https://github.com/Uspro7/antigravity2-cn-Linux.git`)*

* **或直接下載 ZIP 壓縮包 📦**：
  點擊頁面右上角 **Code -> Download ZIP**，下載後解壓至本機任意目錄。

---

### 2. 一鍵安裝中文化

1. **完全退出** Antigravity 軟體。
2. 進入本專案目錄，執行安裝指令碼：
   ```bash
   ./双击安装繁体中文.sh
   ```
   *(也可以在 Linux 圖形檔案管理器中直接雙擊該指令碼)*
3. 依終端機提示選擇左上角品牌名稱顯示方式：
   - **[1] 顯示英文 Antigravity（推薦）**：保留官方英文名稱，排版緊湊。
   - **[2] 不顯示品牌名**：隱藏標題左上角品牌名稱。
   - **[3] 顯示中文品牌名**：顯示為繁體中文品牌名。
4. 執行完成後啟動 Antigravity 用戶端，即可暢享全繁體中文介面！

> **需要簡體中文？**
> 執行 `./双击安装中文汉化.sh` 即可一鍵部署簡體中文。

#### 進階命令列參數

如果您透過終端機直接呼叫 `localization_engine.js`，可以使用以下參數：

```bash
# 手動指定安裝目錄 (若未自動偵測到您的自訂路徑)
node localization_engine.js --install-dir /path/to/Antigravity

# 品牌名稱顯示：english (預設) | hidden | translated
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
   ```bash
   ./双击卸载还原官方英文.sh
   ```
3. 指令碼會自動使用安裝時備份的 `app.asar.bak` 無痕還原，並自動清理相關應用快取。

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
4. **重新打包與校驗**：內建純 JS ASAR 打包器重新封裝，計算 SHA256 integrity 保證 Electron 完整性驗證通過，並自動清理舊位元組碼快取。

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

### 1）提示 Permission denied 或權限不足
* **解決**：賦予指令碼執行權限：
  ```bash
  chmod +x *.sh
  ```
  如果您的 Antigravity 安裝在 `/opt` 或 `/usr` 等系統目錄，請使用 `sudo` 執行：
  ```bash
  sudo ./双击安装繁体中文.sh
  ```

### 2）未自動找到 Antigravity 安裝路徑
* **解決**：可以透過 `--install-dir` 手動指定安裝路徑，例如：
  ```bash
  node localization_engine.js --install-dir /home/你的使用者名稱/ProgramFile/Antigravity-x64
  ```
  也可以設定環境變數：
  ```bash
  export ANTIGRAVITY_INSTALL_DIR="/home/你的使用者名稱/ProgramFile/Antigravity-x64"
  ./双击安装繁体中文.sh
  ```

### 3）軟體官方版本更新後中文化失效了怎麼辦？
* 官方更新會覆蓋 `app.asar` 檔案。只需完全退出軟體，重新執行一次 `./双击安装繁体中文.sh` 即可重新部署中文化！

---

## 🤝 致謝與聲明

- 本專案上游倉庫：**[qqxpee/antigravity2-cn](https://github.com/qqxpee/antigravity2-cn)**，感謝原作者整理的詳盡詞典與基礎架構！本專案僅針對 Linux 平台進行了專屬適配與指令碼編寫。
- Windows / macOS 用戶請前往上游倉庫取得對應的官方一鍵指令碼。
- 歡迎提交 Issue 與 PR 共同完善 Linux 中文生態！
