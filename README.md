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

| 子命令                     | pacman 命令         | yay/paru 命令       | 支持情况     | 说明                         |
|----------------------------|---------------------|---------------------|-------------|------------------------------|
| install / i                | sudo pacman -S      | paru/yay -S         | ✅ 全部支持 | 安装软件包                   |
| uninstall / remove / rm / r| sudo pacman -Rns    | paru/yay -Rns       | ✅ 全部支持 | 彻底删除软件包（含依赖）     |
| update / up / u            | sudo pacman -Syu    | paru/yay -Syu       | ✅ 全部支持 | 更新官方仓库所有包           |
| search / s                 | pacman -Ss          | paru/yay -Ss        | ✅ 全部支持 | 搜索软件包                   |

#### 包信息查询 ####

| 子命令                     | pacman 命令         | yay/paru 命令       | 支持情况     | 说明                         |
|----------------------------|---------------------|---------------------|-------------|------------------------------|
| info                       | pacman -Si          | paru/yay -Si        | ✅ 全部支持 | 查看包信息                   |
| info-aur                   | _不支持_            | paru/yay -Si --aur  | ❌ pacman不支持 | AUR包信息查询                |
| list / ls                  | pacman -Q           | paru/yay -Q         | ✅ 全部支持 | 列出已安装包                 |
| list aur                   | _不支持_            | paru/yay -Qm        | ❌ pacman不支持 | 列出AUR安装的包             |
| why                        | pacman -Qi          | paru/yay -Qi        | ✅ 全部支持 | 查看包安装原因               |

#### 系统维护 ####

| 子命令                     | pacman 命令         | yay/paru 命令       | 支持情况     | 说明                         |
|----------------------------|---------------------|---------------------|-------------|------------------------------|
| clean / c                  | _不支持_            | paru/yay -Sc        | ❌ pacman不支持 | 清理缓存包                   |
| orphan / orphans           | pacman -Qtd         | paru/yay -Qtd       | ✅ 全部支持 | 列出孤儿包                   |
| autoremove / ar            | _使用pacman -Rns_   | _使用paru/yay -Rns_ | ✅ 全部支持 | 自动删除孤儿包               |
| check / ck                 | pacman -Qk          | paru/yay -Qk        | ✅ 全部支持 | 检查包完整性                 |

#### 高级操作 ####

| 子命令                     | pacman 命令         | yay/paru 命令       | 支持情况     | 说明                         |
|----------------------------|---------------------|---------------------|-------------|------------------------------|
| download / dl              | _不支持_            | paru/yay -Sw        | ❌ pacman不支持 | 仅下载不安装                 |
| diff                       | _不支持_            | paru/yay -Du --diff | ❌ pacman不支持 | 查看版本差异，需要pacman-contrib |

#### 特殊功能 ####

| 子命令                     | pacman 命令         | yay/paru 命令       | 支持情况     | 说明                         |
|----------------------------|---------------------|---------------------|-------------|------------------------------|
| update --aur               | _不支持_            | paru/yay -Syua      | ❌ pacman不支持 | 仅更新AUR包                 |
| help / -h / --help         | pacman --help        | paru/ysy --help        | ✅ 全部支持 | 显示帮助信息                 |


### 注意事项 ###

- 上表未列出的子命令会直接透传给原生命令
- pacman 需要 `sudo` 权限的操作会自动添加，理论上加不加 `sudo` 都可以正常工作
- `yay` 和 `paru` 命令依赖于同名包管理器，安装后才能使用上述命令