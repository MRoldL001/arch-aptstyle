> [!TIP]
> You can read this in [English](README_EN.md)

> [!IMPORTANT]
> The English version of the README is updated infrequently. It is recommended to refer to this file instead.

> [!IMPORTANT]
> 英文版 README 很长时间才会维护一次，建议查看本文档

<div align="center">
  <img src="arch-aptstyle.png" alt="LOGO" width="300">
</div>

# arch-aptstyle

**arch-aptstyle** 是一个 *“离经叛道式”* 的用于 **Arch Linux** 的 `zsh` 脚本，旨在为来自 **Debian**、**Ubuntu** 等发行版的用户提供类 `apt` 的包管理命令封装。

通过提供一系列 `apt` 风格的 Arch Linux 包管理指令，只需在输入命令时多敲一个 `a` 就能在迁移至 Arch 时以更熟悉的操作习惯快速上手，无需重新学习各类包管理工具的语法。

## 🚀 快速开始

### 依赖项

- `Arch Linux` 或基于 `Arch` 的Linux发行版
- `zsh` 终端环境
- *(非必须)* 建议使用[Oh My Zsh](https://ohmyz.sh/)作为插件管理器
- *(非必须)* 安装包管理器 `yay` `paru` 以使用所有功能

### 克隆仓库

如果你安装了 **Oh My Zsh**

```zsh
git clone https://github.com/mroldl001/arch-aptstyle.git ~/.oh-my-zsh/plugins
```

---

如果没有安装，将它随便 `clone` 到一个地方，比如`~/arch-aptstyle`

```zsh
git clone https://github.com/mroldl001/arch-aptstyle.git ~/arch-aptstyle
```

### 加载脚本

如果你安装了 **Oh My Zsh**，在 `~/.zshrc` 中加入

```zsh
plugins=(arch-aptstyle)
```

如果你此前已经创建过 plugins 列表了，直接将 arch-aptstyle 加入到其中就可以

---

如果没有安装，建议的做法是在 `~/.zshrc` 中加入

```zsh
source ~/arch-aptstyle/arch-aptstyle.plugin.zsh
```

这样便于后续的插件管理，当然你也可以通过直接加载这个 `.zsh` 文件来让其生效

### 重新加载配置

```zsh
source ~/.zshrc
```

现在，你可以通过 `pacmana update` `yaya remove <pkg>` `parua i <pkg>` 等一系列 apt 风格指令来进行包管理了！

## 📖 使用指南

在 `Arch Linux` 或基于 `Arch` 的Linux发行版的常用包管理器 `pacman` `yay` `paru` 后加一个 `a` ，变成 `pacmana` `yaya` `parua` ，就能快速享受 apt 风格所带来的熟悉体验!

### 命令对照表(附说明)

#### 1. 基本操作

| 子命令                                 | 选项           | pacman 命令          | yay/paru 命令                         | 支持情况        | 说明           |
| ----------------------------------- | ------------ | ------------------ | ----------------------------------- | ----------- | ------------ |
| `install` / `i`                     |              | `sudo pacman -S`   | `paru/yay -S`                       | ✅ 全部支持      | 安装软件包        |
| `uninstall` / `remove` / `rm` / `r` |              | `sudo pacman -Rns` | `paru/yay -Rns`                     | ✅ 全部支持      | 彻底删除软件包（含依赖） |
| `update` / `upd`                    |              | `sudo pacman -Sy`  | `paru/yay -Sy`                      | ✅ 全部支持      | 更新包缓存，pacman仅更新官方包缓存    |
| `upgrade` / `upg`                   |              | `sudo pacman -Su`  | `paru/yay -Su`                      | ✅ 全部支持      | 更新所有包，pacman仅更新官方包    |
| `search` / `s`                      |              | `pacman -Ss`       | `pacman -Ss` 与 `paru/yay -Ss --aur` | ✅ 全部支持      | 搜索软件包        |
| `search` / `s`                      | `--official` | `pacman -Ss`       | `pacman -Ss`                        | ✅ 全部支持      | 仅搜索官方包       |
| `search` / `s`                      | `--aur`      | *不支持*              | `paru/yay -Ss --aur`                | ❌ pacman不支持 | 仅搜索AUR包      |

---

#### 2. 包信息查询

| 子命令                  | 选项             | pacman 命令      | yay/paru 命令          | 支持情况        | 说明             |
| -------------------- | -------------- | -------------- | -------------------- | ----------- | -------------- |
| `show`               |                | `pacman -Si`   | `paru/yay -Si`       | ✅ 全部支持      | 查看包信息          |
| `show`               | `--installed`  | `pacman -Qi`   | `paru/yay -Qi`       | ✅ 全部支持      | 查看已安装的包信息      |
| `show`               | `--aur`        | *不支持*          | `paru/yay -Si --aur` | ❌ pacman不支持 | 查看AUR包信息       |
| `list` / `ls`        |                | `pacman -Q`    | `paru/yay -Q`        | ✅ 全部支持      | 列出所有包          |
| `list` / `ls`        | `--upgradable` | `pacman -Qu`   | `paru/yay -Qu`       | ✅ 全部支持      | 列出可升级包         |
| `list` / `ls`        | `--installed`  | `pacman -Q`    | `paru/yay -Q`        | ✅ 全部支持      | 列出已安装包（排除可升级的） |
| `list` / `ls`        | `--unofficial` | `paru/yay -Qm` | `paru/yay -Qm`       | ✅ 全部支持      | 列出非官方包         |
| `orphan` / `orphans` |                | `pacman -Qtd`  | `paru/yay -Qtd`      | ✅ 全部支持      | 列出孤儿包          |

---

#### 3. 系统维护

| 子命令                 | 选项  | pacman 命令        | yay/paru 命令         | 支持情况   | 说明               |
| ------------------- | --- | ---------------- | ------------------- | ------ | ---------------- |
| `clean` / `c`       |     | `sudo pacman -Sc`     | `paru/yay -Sc`      | ✅ 全部支持 | 清理缓存包            |
| `autoremove` / `ar` |     | *使用了pacman -Rns* | **使用了paru/yay -Rns* | ✅ 全部支持 | 自动删除孤儿包 *(谨慎使用)* |
| `check` / `ck`      |     | `pacman -Qk`     | `paru/yay -Qk`      | ✅ 全部支持 | 检查包完整性           |

---

#### 4. 其它操作

| 子命令                      | 选项  | pacman 命令       | yay/paru 命令       | 支持情况   | 说明     |
| ------------------------ | --- | --------------- | ----------------- | ------ | ------ |
| `download` / `dl`        |     | `sudo pacman -Sw`    | `paru/yay -Sw`    | ✅ 全部支持 | 仅下载不安装 |
| `help` / `-h` / `--help` |     | `pacman --help` | `paru/ysy --help` | ✅ 全部支持 | 显示帮助信息 |

> [!IMPORTANT]
> - 上表未列出的子命令会直接透传给原生命令
> - pacman 需要 `sudo` 权限的操作会自动添加，请不要主动添加 `sudo` 
> - `yaya` 和 `parua` 命令依赖于去掉 `a` 的同名包管理器，安装后才能使用上述命令
> - ~~`update` 和 `upgrade` 都封装了 `--Syu` ，你可以通过上述指令的任意一种来更新官方仓库的所有包~~
> - 现在，`update` 和 `upgrade` 是解耦的，你可以通过它们将更新包缓存与升级软件包分开处理
> - list 和 search 可能存在 BUG，如果遇到请在 issues 中提出

### 常见提示信息及应对指南

| 提示信息                                                                      | 应对方法                                                                       |
| ------------------------------------------------------------------------- | -------------------------------------------------------------------------- |
| `[E] arch-aptstyle:'pacman' not found. Please use an Arch-based system.`  | 该插件专为 `Arch Linux` 或 基于 `Arch` 的 Linux 发行版设计，`pacman`如果不存在的话大概率说明你在使用其它发行版 |
| `[E] arch-aptstyle: ... does not support ... `                            | 你所使用的包管理器不支持该操作，更换包管理器或使用其他命令                                              |
| `[I] arch-aptstyle:No orphan packages to remove.`                         | 你没有孤儿包，不需要清理                                                               |
| `[E] arch-aptstyle: ... autoremove failed.`                               | 请通过issue报告给开发者                                                             |
| `[E] arch-aptstyle: missing arguments. Usage: <tool> <command> [args...]` | 缺少子命令，参见**命令对照表**                                                           |
| `[E] arch-aptstyle:list: unknown option ...` | 输入的选项未知，参见**命令对照表**                                                           | 
| `[E] arch-aptstyle: Cannot specify both options at the same time.` | 请不要同时使用多个参数                                                     |

## 📝 更新日志

- 	dev2025527-0008: (从此版本开始追踪变化，因为这是我认为第一个可被正常使用的 dev 版本)✨♻️🔥
  
  - 解耦了 update 和 upgrade
  - 删除了子命令 diff, why
  - 将子命令 info 更名为 show 以与 apt 的子命令一致
  - 重构了子命令 show, list, search 现在它们更加符合你的习惯了
  - 重构了一部分代码的实现方法

- dev20250527-0051:	 🐛
  
  - 修复了子命令 search 的一系列 bug

- 	dev20250527-0147:	 🐛♻️
  
  - 修复了子命令 list 的一系列 bug，加入了新选项项 --unofficial，用来列出所有非官方本地包
  - 重构了多参数判断和 flag 类变量命名，使整体保持统一

- 	dev2025527-0205: 	🐛
  
  - 修复了子命令 clean 和 download 的一系列 bug

- 	dev20250527-0217: 🐛
  
  - 修复了子命令 update 和 upgrade 的一系列bug

- 	**v1.0.0-BakaTesutoShokanju**(dev20250527-0229): 	🐛♻️🚀

  - 重构了 show 判断多参数的逻辑
  - 修复了一些微小的 bug
  - 现在它准备好作为正式版来被发布了

## ✨ 致谢

- 感谢 [sskka235](https://github.com/sskka235) 为 `dev` 版本所提供的测试支持
