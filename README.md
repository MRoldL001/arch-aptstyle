# arch-aptstyle #

**arch-aptstyle** 是一个 *“离经叛道式”* 的用于 **Arch Linux** 的 `zsh` 脚本，旨在为来自 **Debian**、**Ubuntu** 等发行版的用户，提供类 `apt` 的包管理命令封装。

通过提供一系列 `apt` 风格的 Arch Linux 包管理指令，使用户在迁移至 Arch 时能够以更熟悉的操作习惯快速上手，无需重新学习各类包管理工具的语法。

## 快速开始 ##

### 依赖项 ###

- Arch Linux 或基于 Arch 的Linux发行版
- zsh 终端环境
- *(非必须)* 建议使用[Oh My Zsh](https://ohmyz.sh/)作为插件管理器
- *(非必须)* 安装包管理器 `yay` `paru` 以使用所有功能

### 克隆仓库 ###

如果你安装了 **Oh My Zsh**

```zsh
git clone https://github.com/mroldl001/arch-aptstyle.git ~/.oh-my-zsh/plugins
```

---

如果没有安装，将它随便 `clone` 到一个地方，比如`~/arch-aptstyle`

```zsh
git clone https://github.com/mroldl001/arch-aptstyle.git ~/arch-aptstyle
```

### 加载脚本 ###

如果你安装了 **Oh My Zsh**，在 `~/.zshrc` 中加入
```zsh
plugins=(arch-aptstyle)
```

如果你此前已经创建过 plugins 列表了，直接将 arch-aptstyle 加入到其中就可以

---

如果没有安装，建议的做法是在 `~/.zshrc` 中加入

```zsh
source ~/arch-aptstyle/arch-aptstyle.zsh
```

这样便于后续的插件管理，当然你也可以通过直接加载这个 `.zsh` 文件来让其生效

### 重新加载配置 ###

```zsh
source ~/.zshrc
```

现在，你可以通过 `pacman update` `yay remove <pkg>` `paru i <pkg>` 等一系列apt风格指令来进行包管理了！

## 使用指南 ##

### 命令对照表(附说明) ###

#### 基本操作 ####

| 子命令               | 对应命令                   | 支持情况           | 使用说明                                                                 |
|----------------------|---------------------------|-------------------|--------------------------------------------------------------------------|
| `install`/`i`        | `sudo pacman -S`          | ✅ 全部支持       | 安装软件包，例：`pacman install nano`                                   |
|                      | `paru/yay -S`             |                   | 支持同时安装AUR包，例：`paru install google-chrome`                     |
| `uninstall`/`rm`/`r` | `sudo pacman -Rns`        | ✅ 全部支持       | 彻底删除软件包(含依赖)，例：`yay remove firefox`                        |
|                      | `paru/yay -Rns`           |                   |                                                                         |
| `update`/`up`/`u`    | `sudo pacman -Syu`        | ✅ 全部支持       | 更新所有官方仓库包，例：`pacman update`                                 |
|                      | `paru/yay -Syu [--aur]`   |                   | `--aur`参数可同时更新AUR包，例：`yay update --aur`                      |
| `search`/`s`         | `pacman -Ss`              | ✅ 全部支持       | 搜索软件包，例：`paru search java`                                      |
|                      | `paru/yay -Ss`            |                   | 支持搜索AUR仓库                                                         |

#### 包信息查询 ####

| 子命令               | 对应命令                   | 支持情况           | 使用说明                                                                 |
|----------------------|---------------------------|-------------------|--------------------------------------------------------------------------|
| `info`               | `pacman -Si`              | ✅ 全部支持       | 查看包信息，例：`yay info python`                                       |
|                      | `paru/yay -Si`            |                   |                                                                         |
| `info-aur`           | _不支持_                  | ❌ pacman不支持   | 专查AUR包信息，例：`paru info-aur visual-studio-code-bin`               |
|                      | `paru/yay -Si --aur`      |                   |                                                                         |
| `list`/`ls`          | `pacman -Q`               | ✅ 全部支持       | 列出已安装包，例：`pacman list`                                         |
|                      | `paru/yay -Q`             |                   |                                                                         |
| `list aur`           | _不支持_                  | ❌ pacman不支持   | 仅列AUR安装的包，例：`yay list aur`                                     |
|                      | `paru/yay -Qm`            |                   |                                                                         |
| `why`                | `pacman -Qi`              | ✅ 全部支持       | 查看包安装原因，例：`paru why linux-headers`                            |
|                      | `paru/yay -Qi`            |                   |                                                                         |

#### 系统维护 ####

| 子命令               | 对应命令                   | 支持情况           | 使用说明                                                                 |
|----------------------|---------------------------|-------------------|--------------------------------------------------------------------------|
| `clean`/`c`          | _显示错误_                | ❌ pacman不支持   | 清理缓存包，例：`paru clean`                                            |
|                      | `paru/yay -Sc`            |                   | 需手动确认删除                                                          |
| `orphan`/`orphans`   | `pacman -Qtd`             | ✅ 全部支持       | 列出孤儿包，例：`yay orphans`                                           |
|                      | `paru/yay -Qtd`           |                   |                                                                         |
| `autoremove`/`ar`    | 删除孤儿包                 | ✅ 全部支持       | 自动删除孤儿包，例：`pacman autoremove`                                 |
|                      | (使用`-Rns`)              |                   | 无孤儿包时显示友好提示                                                  |
| `check`/`ck`         | `pacman -Qk`              | ✅ 全部支持       | 检查包完整性，例：`paru check`                                          |
|                      | `paru/yay -Qk`            |                   |                                                                         |

#### 高级操作 ####

| 子命令               | 对应命令                   | 支持情况           | 使用说明                                                                 |
|----------------------|---------------------------|-------------------|--------------------------------------------------------------------------|
| `download`/`dl`      | _显示错误_                | ❌ pacman不支持   | 仅下载不安装，例：`yay download spotify`                                |
|                      | `paru/yay -Sw`            |                   | 包文件保存在`/var/cache/pacman/pkg/`                                    |
| `diff`               | _显示错误_                | ❌ pacman不支持   | 查看版本差异，例：`paru diff linux`                                     |
|                      | `paru/yay -Du --diff`     |                   | 需先安装`pacman-contrib`                                                |

#### 特殊功能 ####

| 子命令               | 对应命令                   | 支持情况           | 使用说明                                                                 |
|----------------------|---------------------------|-------------------|--------------------------------------------------------------------------|
| `update --aur`       | `paru/yay -Syua`          | ✅ paru/yay支持   | 仅更新AUR包，例：`yay update --aur`                                     |
| `autoremove`         | `paru/yay -Rns $(Qtdq)`   | ✅ 全部支持       | 自动移除孤儿包，无包可移时显示：`[I] 无孤儿包可移除`                     |
| `help`/`-h`/`--help` | 透传原生`--help`          | ✅ 全部支持       | 显示帮助信息，例：`pacman --help`                                        |

### 注意事项 ###

- 上表未列出的子命令会直接透传给原生命令
- pacman 需要 `sudo` 权限的操作会自动添加，理论上加不加 `sudo` 都可以正常工作
- `yay` 和 `paru` 命令依赖于同名包管理器，安装后才能使用上述命令