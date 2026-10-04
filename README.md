# Antigravity 2.0 中文语言包 & 汉化引擎 (Linux / Windows / macOS)

👉 **[繁體中文版說明文件 (Traditional Chinese README)](README_TW.md)**

> **支持系统**：Linux & Windows & macOS (全平台均内置一键脚本)  
> **匹配版本**：Antigravity v2.12.2+  
> **核心引擎**：Node.js (**内置纯 JS 零依赖 ASAR 解包与打包引擎，100% 离线极速运行**)  
> **汉化范围**：软件主界面、顶部系统菜单、任务栏/托盘右键菜单、加载动画、参数设置面板、新手引导及登录页。  
> **注入原理**：基于 ASAR 物理层解包与精准重包机制，安全注入 `preload.js` 动态翻译引擎与菜单 patch，绝不破坏核心二进制，支持随时一键无痕还原官方原版。  
> **开源说明**：本项目基于优秀开源项目 [qqxpee/antigravity2-cn](https://github.com/qqxpee/antigravity2-cn) 进行深度二次开发与增强，重点打造了 **Linux 平台的原生适配**，并重构内置了 **零依赖纯 JS ASAR 引擎**，彻底摆脱原版对 `npx @electron/asar` 及外网下载的依赖。

---

## ✨ Linux 增强版核心特性

- 🐧 **原生 Linux 深度适配**：
  - 自动探测主流 Linux 发行版（Ubuntu、Debian、Fedora、Arch Linux、openSUSE 等）的各类安装位置（`~/ProgramFile/Antigravity-x64`、`/opt/Antigravity`、`~/.local/share/antigravity` 等）。
  - 支持通过 `which antigravity`、`.desktop` 桌面图标及运行中进程 `/proc/<pid>/exe` 智能推导安装路径。
  - 精准识别 GUI 进程，关闭客户端时绝不误杀后台 `language_server` 智能体分析服务。
  - 针对系统级目录（如 `/opt`）支持智能 `sudo` 提权检测。
- ⚡ **内置纯 JS 零依赖 ASAR 引擎**：
  - 原版依赖 `npx -y @electron/asar` 联网拉取依赖，国内网络或代理异常时极易卡死或报错（如 403 Forbidden）。
  - 本项目内置原生 JavaScript Chromium Pickle / ASAR 引擎，自动计算并填充 4MB 分块 SHA256 integrity 校验哈希，解包与重打包仅需 **100~200 毫秒**，纯离线可用。
- 🖱️ **一键双击与终端多模态支持**：
  - 内置 `.sh` 脚本既可在终端中直接执行，也支持在 Linux 桌面文件管理器（GNOME Nautilus、KDE Dolphin、XFCE 等）中直接双击自动唤起独立终端窗口交互运行。

---

> [!WARNING]
> **关于聊天历史记录/对话框内容被汉化的已知问题及匹配机制说明（开发者必读）**：
> - **现象**：当你在聊天或对话框中发送了某些与软件界面 UI 完全相同的英文关键词或句子时，该对话气泡在界面上可能会被翻译引擎汉化显示。
> - **核心匹配机制**：
>   - **短词（长度 <= 15 字符，如 `Knowledge`）**：翻译仅在词条 **完全精准匹配（且单独占一行）** 时触发。如果该词前后有其他任何字符、空格或标点符号（如 `Knowledge是什么`、`哈哈 Knowledge`），则 **绝对不会** 被翻译。如果需要强行阻止其翻译，可使用中文双引号将其包裹（如 `“Knowledge”`）即可完美规避。
>   - **长句（长度 > 15 字符，如 `Enable Antigravity to deploy apps...`）**：由于需要兼容界面动态渲染，长句采用 **“子串滑动替换”** 算法。这意味着只要输入的文本中包含了这一长串完整英文字句，该段子串就会被自动翻译成中文（即使加了引号或前后带有文字）。但由于长句匹配极其苛刻，必须一字不差（包括大小写、标点和空格），因此实际聊天中几乎不可能误触发。
> - **说明**：这**不影响 AI 接收到的原文**。大模型获取到的依旧是你发送的纯正英文原始指令，仅在软件的视觉渲染层面发生了汉化，纯属视觉影响，无需担心影响大模型的效果。

---

## 📸 汉化效果展示

以下是部分功能板块的实际汉化效果展示，涵盖登录引导页、主编辑器界面与详细设置面板：

### 1. 欢迎页与登录新手引导
![欢迎页与登录新手引导](./showimg/showlogin.png)

### 2. 主编辑器界面与菜单
![主编辑器界面与菜单](./showimg/showmain.png)

### 3. 详细参数设置面板
![详细参数设置面板](./showimg/showmenu.png)

---

## 📂 项目文件结构

```text
├── 双击安装中文汉化.sh          # [Linux] 简体中文一键安装入口
├── 双击安装繁体中文.sh          # [Linux] 繁体中文一键安装入口
├── 双击卸载还原官方英文.sh      # [Linux] 一键卸载恢复官方英文入口
├── 双击安装中文汉化.bat         # [Windows] 简体中文一键安装
├── 双击安装繁体中文.bat         # [Windows] 繁体中文一键安装
├── 双击卸载还原官方英文.bat     # [Windows] 一键卸载恢复
├── 双击安装中文汉化.command     # [macOS] 简体中文一键安装
├── 双击安装繁体中文.command     # [macOS] 繁体中文一键安装
├── 双击卸载还原官方英文.command # [macOS] 一键卸载恢复
├── localization_engine.js      # 核心跨平台汉化引擎 (内置纯 JS 零依赖 ASAR 模块)
├── dicts/                      # 简体中文模块化对照词典 (JSON)
├── dicts_tw/                   # 繁体中文模块化对照词典 (JSON)
├── showimg/                    # 界面效果预览截图
├── README.md                   # 简体中文说明文档
└── README_TW.md                # 繁体中文说明文档
```

---

## 🚀 极速使用指南

### 1. 获取代码

* **通过 Git 命令行克隆（推荐 💻）**：
  ```bash
  git clone https://github.com/Uspro7/antigravity2-cn-Linux.git
  cd antigravity2-cn-Linux
  ```
  *(若在国内网络受限，可使用镜像地址：`git clone https://mirror.ghproxy.com/https://github.com/Uspro7/antigravity2-cn-Linux.git`)*

* **或直接下载 ZIP 压缩包 📦**：
  点击页面右上角 **Code -> Download ZIP**，下载后解压至本地任意目录。

---

### 2. 一键安装汉化

1. **完全退出** Antigravity 软件。
2. 运行安装脚本：
   - **Linux**：在终端运行 `./双击安装中文汉化.sh`（或在图形文件管理器中直接双击运行）。
   - **Windows**：双击运行 `双击安装中文汉化.bat`。
   - **macOS**：双击运行 `双击安装中文汉化.command`。
3. 按提示选择左上角品牌名展示方式：
   - **[1] 显示英文 Antigravity（推荐）**：保留官方英文名称，排版紧凑。
   - **[2] 不显示品牌名**：隐藏标题左上角品牌名称。
   - **[3] 显示中文品牌名**：显示为“反重力智能编程”。
4. 运行完成后启动 Antigravity 软件，即可畅享全中文界面！

> **需要繁体中文？**
> 运行对应的 `双击安装繁体中文.sh` / `.bat` / `.command` 即可一键部署繁体中文。

#### 高级命令行参数

如果您通过终端调用 `localization_engine.js`，可以使用以下参数：

```bash
# 指定安装目录 (若未自动探测到您的自定义路径)
node localization_engine.js --install-dir /path/to/Antigravity

# 控制品牌名称模式：english(默认) | hidden | translated
node localization_engine.js --brand-title english

# 繁体中文模式
node localization_engine.js --tw

# 跳过自动关闭运行中客户端
node localization_engine.js --no-kill

# 一键卸载恢复官方原版
node localization_engine.js --huifu
```

---

### 3. 一键卸载还原

若需要升级软件或还原至官方纯净英文版：
1. 完全退出 Antigravity。
2. 运行卸载脚本：
   - **Linux**：运行 `./双击卸载还原官方英文.sh`
   - **Windows**：运行 `双击卸载还原官方英文.bat`
   - **macOS**：运行 `双击卸载还原官方英文.command`
3. 脚本会自动使用安装时备份的 `app.asar.bak` 无痕还原，并自动清理相关应用缓存。

---

## 🔌 可选高级功能：网络透明代理自动注入 (Windows 免 TUN 方案)

如果您处于网络受限环境（例如连通 Google AI / Gemini 接口受阻），且不希望开启系统的全局虚拟网卡/TUN 模式，本项目在 Windows 下支持在安装汉化时**自动联动注入免 TUN 强制代理工具**。

该方案基于优秀的开源项目 **[yuaotian/antigravity-proxy](https://github.com/yuaotian/antigravity-proxy)**（基于 MinHook 的 DLL 劫持透明代理）。

### 使用方法：
1. 前往 **[yuaotian/antigravity-proxy](https://github.com/yuaotian/antigravity-proxy)** 获取编译好的文件：
   - `version.dll`、`dbghelp.dll`、`config.json`
2. 在当前汉化项目根目录新建 `proxy_config` 文件夹（已配置 `.gitignore`，不会被 Git 提交）。
3. 将上述文件按本地代理端口配置好后放入 `proxy_config/` 目录。
4. 正常运行 `双击安装中文汉化.bat`，引擎将**自动检测并一次性完成汉化与代理模块注入**。

---

## 🛠️ 汉化原理说明

本引擎专为 **Antigravity 2.0+** 的 Electron 架构量身定制：
1. **自动释放锁**：运行前智能探测并安全关闭主界面进程，防止文件占用锁定。
2. **安全备份**：首次运行时自动创建 `app.asar.bak` 原始包备份，确保随时可无损一键复原。
3. **精准注入**：
   - `preload.js`：采用 WeakSet 记录与 Shadow DOM 穿透，启动高效的 `MutationObserver` 引擎，动态监测并将渲染层文本翻译为中文。
   - `menu.js`：深度打补丁系统原生顶部菜单。
   - `tray.js`：汉化任务栏托盘与右键通知状态菜单。
   - `loadingOverlay.js`：注入趣味加载动画提示文案。
   - `updater.js`：汉化更新提示弹窗。
4. **重新打包与校验**：内置 ASAR 打包器重新封装，计算 SHA256 integrity 保证 Electron 完整性校验通过，并自动清理旧字节码缓存。

---

## 💡 如何通过 AI 助手自动补充或修改汉化？

在使用过程中如果发现未翻译或漏译的英文，**您可以直接在 Antigravity 聊天窗口中让 AI 助手帮您补充词典**！

> [!TIP]
> **最佳姿势**：在 Antigravity 中点击 **“打开文件夹 (Open Folder)”**，直接将本汉化包目录作为**项目/工作区**打开，在当前窗口中向 AI 发送截图或文字即可！
> - **截图提示词**：> *“帮我把这张截图里所有未汉化的英文选项和面板内容补全到中文词典中。”*
> - **文字提示词**：> *“帮我把漏译的英文 'Allow agent to view and edit files outside workspace' 汉化为 '允许智能体编辑工作区外的文件'。”*
>
> 词典修改保存后，只需重新运行一次安装脚本即可立即生效！

---

## ❓ 常见问题解答 (FAQ)

### 1）Linux 提示 Permission denied 或权限不足
* **解决**：赋予脚本执行权限：
  ```bash
  chmod +x *.sh
  ```
  如果您的 Antigravity 安装在 `/opt` 或 `/usr` 等系统目录，请使用管理员权限运行：
  ```bash
  sudo ./双击安装中文汉化.sh
  ```

### 2）Linux 未能自动找到 Antigravity 安装路径
* **解决**：可以使用 `--install-dir` 手动指定安装路径，例如：
  ```bash
  node localization_engine.js --install-dir /home/你的用户名/ProgramFile/Antigravity-x64
  ```
  也可以设置环境变量：
  ```bash
  export ANTIGRAVITY_INSTALL_DIR="/home/你的用户名/ProgramFile/Antigravity-x64"
  ./双击安装中文汉化.sh
  ```

### 3）macOS 提示“无法打开”或权限问题
* **解决**：在终端中执行 `chmod +x *.command`。本引擎已内置自动本地 Ad-hoc 深度重签名机制 (`codesign`)，自动消除修改后的系统安全拦截警告。

### 4）软件官方版本更新后汉化失效了怎么办？
* 软件官方升级会覆盖 `app.asar` 文件。只需完全退出软件，重新运行一次安装脚本即可重新部署汉化！

---

## 🤝 致谢与声明

- 核心字典与基础逻辑致谢上游项目：**[qqxpee/antigravity2-cn](https://github.com/qqxpee/antigravity2-cn)**
- Windows 透明代理方案致谢：**[yuaotian/antigravity-proxy](https://github.com/yuaotian/antigravity-proxy)**
- 欢迎提交 Issue 与 PR 共同完善全平台中文生态！
