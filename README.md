# Antigravity 2.0 Linux 中文语言包 & 汉化引擎

👉 **[繁體中文版說明文件 (Traditional Chinese README)](README_TW.md)**

> [!IMPORTANT]
> **关于上游仓库与本项目定位**：  
> 本项目的上游仓库是 **[qqxpee/antigravity2-cn](https://github.com/qqxpee/antigravity2-cn)**。上游原版主要面向 Windows 与 macOS 平台，**我们只做了 Linux 平台的适配工作**（包括 Linux 目录探测、Linux 进程管理与内置零依赖纯 JS ASAR 引擎）。汉化词库与基础注入逻辑均来自于上游仓库。如果您使用的是 Windows 或 macOS，请直接前往上游仓库获取对应版本。

> **支持系统**：Linux (Ubuntu / Debian / Fedora / Arch Linux / openSUSE / Deepin / Manjaro 等所有主流发行版)  
> **匹配版本**：Antigravity v2.12.2+  
> **核心引擎**：Node.js (**内置纯 JS 零依赖 ASAR 解包与打包引擎，100% 离线极速运行**)  
> **汉化范围**：包括软件界面、顶部系统菜单、任务栏托盘右键菜单、加载动画、参数设置面板、新手引导及登录页。  
> **注入原理**：基于 ASAR 物理层解包与精准重包机制，安全注入 `preload.js` 动态翻译机制，绝不修改核心二进制，支持一键无痕还原官方英文原版。

---

## ✨ Linux 核心特性

- 🐧 **Linux 深度适配与智能路径探测**：
  - 自动识别用户级常见目录：`~/ProgramFile/Antigravity-x64`、`~/ProgramFile/Antigravity`、`~/Programs/Antigravity`、`~/.local/share/antigravity` 等。
  - 自动识别系统级安装目录：`/opt/Antigravity`、`/opt/Antigravity-x64`、`/usr/share/antigravity` 等。
  - 自动通过 `which antigravity` 及系统 `.desktop` 快捷方式解析真实安装路径。
  - 支持通过 `/proc/<pid>/exe` 反查当前运行中的客户端路径。
- ⚡ **内置纯 JS 零依赖 ASAR 引擎**：
  - 无需联网，无需安装额外 npm 包，无需配置 npm 代理。
  - 内置原生 JavaScript Chromium Pickle / ASAR 引擎，自动计算并填充 4MB 分块 SHA256 integrity 完整性校验哈希。
  - 解包与打包仅需 **100~200 毫秒**，极速且 100% 离线稳定。
- 🛡️ **进程安全管理与权限提权**：
  - 精准识别 GUI 主进程，关闭客户端时绝不误杀后台 `language_server` 智能体语言服务。
  - 当 Antigravity 安装在系统目录（如 `/opt`）且当前用户无写权限时，自动触发 `sudo` 提权或给出友好提示。
- 🖱️ **终端与图形桌面双模态支持**：
  - 脚本既可在终端中直接运行，也支持在 Linux 桌面文件管理器（GNOME Nautilus、KDE Dolphin、XFCE 等）中直接双击自动拉起独立终端窗口交互运行。

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

涵盖登录引导页、主编辑器界面与详细设置面板：

### 1. 欢迎页与登录新手引导
![欢迎页与登录新手引导](./showimg/showlogin.png)

### 2. 主编辑器界面与菜单
![主编辑器界面与菜单](./showimg/showmain.png)

### 3. 详细参数设置面板
![详细参数设置面板](./showimg/showmenu.png)

---

## 📂 项目文件结构

```text
├── 双击安装中文汉化.sh          # Linux 简体中文一键安装入口
├── 双击安装繁体中文.sh          # Linux 繁体中文一键安装入口
├── 双击卸载还原官方英文.sh      # Linux 一键卸载恢复官方英文入口
├── localization_engine.js      # 核心汉化引擎 (内置纯 JS 零依赖 ASAR 模块)
├── dicts/                      # 简体中文模块化对照词典 (JSON)
├── dicts_tw/                   # 繁体中文模块化对照词典 (JSON)
├── showimg/                    # 界面效果预览截图
├── README.md                   # 简体中文说明文档
└── README_TW.md                # 繁体中文说明文档
```

---

## 🚀 极速使用指南

### 1. 获取项目代码

* **使用 Git 克隆（推荐 💻）**：
  ```bash
  git clone https://github.com/Uspro7/antigravity2-cn-Linux.git
  cd antigravity2-cn-Linux
  ```
  *(国内网络受限可使用加速地址：`git clone https://mirror.ghproxy.com/https://github.com/Uspro7/antigravity2-cn-Linux.git`)*

* **或直接下载 ZIP 压缩包 📦**：
  点击页面右上角 **Code -> Download ZIP**，下载后解压至本地任意目录。

---

### 2. 一键安装汉化

1. **完全退出** Antigravity 软件。
2. 进入本项目目录，执行安装脚本：
   ```bash
   ./双击安装中文汉化.sh
   ```
   *(也可以在 Linux 图形文件管理器中直接双击该脚本)*
3. 按终端提示选择左上角品牌名展示方式：
   - **[1] 显示英文 Antigravity（推荐）**：保留官方英文名称，排版紧凑。
   - **[2] 不显示品牌名**：隐藏标题左上角品牌名称。
   - **[3] 显示中文品牌名**：显示为“反重力智能编程”。
4. 运行完成后启动 Antigravity 客户端，即可畅享全中文界面！

> **需要繁体中文？**
> 执行 `./双击安装繁体中文.sh` 即可一键部署繁体中文。

#### 高级命令行参数

如果您通过终端直接调用 `localization_engine.js`，可以使用以下参数：

```bash
# 手动指定安装目录 (若未自动探测到您的自定义路径)
node localization_engine.js --install-dir /path/to/Antigravity

# 品牌名称显示：english (默认) | hidden | translated
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
2. 执行卸载脚本：
   ```bash
   ./双击卸载还原官方英文.sh
   ```
3. 脚本会自动使用安装时备份的 `app.asar.bak` 无痕还原，并自动清理相关应用缓存。

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
4. **重新打包与校验**：内置纯 JS ASAR 打包器重新封装，计算 SHA256 integrity 保证 Electron 完整性校验通过，并自动清理旧字节码缓存。

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

### 1）提示 Permission denied 或权限不足
* **解决**：赋予脚本执行权限：
  ```bash
  chmod +x *.sh
  ```
  如果您的 Antigravity 安装在 `/opt` 或 `/usr` 等系统目录，请使用 `sudo` 运行：
  ```bash
  sudo ./双击安装中文汉化.sh
  ```

### 2）未自动找到 Antigravity 安装路径
* **解决**：可以通过 `--install-dir` 手动指定安装路径，例如：
  ```bash
  node localization_engine.js --install-dir /home/你的用户名/ProgramFile/Antigravity-x64
  ```
  也可以设置环境变量：
  ```bash
  export ANTIGRAVITY_INSTALL_DIR="/home/你的用户名/ProgramFile/Antigravity-x64"
  ./双击安装中文汉化.sh
  ```

### 3）软件官方版本更新后汉化失效了怎么办？
* 官方更新会覆盖 `app.asar` 文件。只需完全退出软件，重新执行一次 `./双击安装中文汉化.sh` 即可重新部署汉化！

---

## 🤝 致谢与声明

- 本项目上游仓库：**[qqxpee/antigravity2-cn](https://github.com/qqxpee/antigravity2-cn)**，感谢原作者整理的详尽词典与基础架构！本项目仅针对 Linux 平台进行了专属适配与脚本编写。
- Windows / macOS 用户请前往上游仓库获取对应的官方一键脚本。
- 欢迎提交 Issue 与 PR 共同完善 Linux 中文生态！
