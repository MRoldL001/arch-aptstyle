# arch-aptstyle #

**arch-aptstyle** 是一个“离经叛道”式的用于 Arch Linux 的 zsh 脚本，旨在为来自 Debian、Ubuntu 等发行版的用户提供类 apt 的包管理命令封装。通过提供一系列 apt 风格的 Arch Linux 包管理指令，使用户在迁移至 Arch 时能够以更熟悉的操作习惯快速上手，无需重新学习各类包管理工具的语法。

## 快速开始 ##

## 依赖项 ##
- Arch Linux 或基于 Arch 的Linux发行版
- zsh 终端环境
- *(非必须)* 建议使用[Oh My Zsh](https://ohmyz.sh/)作为插件管理器

## 克隆仓库 ##
如果你安装了 **Oh My Zsh**
```zsh
git clone https://github.com/mroldl001/arch-aptstyle.git ~/.oh-my-zsh/plugins
```
---
如果没有安装，将它随便 `clone` 到一个地方，比如`~/arch-aptstyle`
```zsh
git clone https://github.com/mroldl001/arch-aptstyle.git ~/arch-aptstyle
```

## 加载脚本 ##
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

## 重新加载配置 ##
```zsh
source ~/.zshrc
```
现在，你可以通过 `pacman update` `yay remove <pkg>` `paru i <pkg>` 等一系列apt风格指令来进行包管理了！# arch-aptstyle