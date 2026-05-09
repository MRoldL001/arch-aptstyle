> [!TIP]
> Translated by ChatGPT and Trae AI, not fully reviewed. You can read this in [简体中文](README.md)

> [!IMPORTANT]
> The English version of the README is updated infrequently. It is recommended to refer to the Simplified Chinese version instead.

> [!IMPORTANT]
> 英文版 README 很长时间才会维护一次，建议查看本文档

<div align="center">
  <img src="arch-aptstyle.png" alt="LOGO" width="300">
</div>

# arch-aptstyle

**arch-aptstyle** is a *"rebellious"* `zsh` script for **Arch Linux**, designed to provide Debian/Ubuntu-style `apt` command wrappers for users transitioning from those distributions.

By offering a set of `apt`-style package management commands, you only need to type an extra `a` to use familiar package management habits while adapting to Arch, without relearning various package manager syntaxes.

## 🚀 Quick Start

### Dependencies

- `Arch Linux` or Arch-based distributions
- `zsh` shell
- *(Optional)* Recommended to use [Oh My Zsh](https://ohmyz.sh/) as your plugin manager
- *(Optional)* Install `yay` or `paru` to enable full functionality

### Clone the Repository

If you are using **Oh My Zsh**:

```zsh
git clone https://github.com/mroldl001/arch-aptstyle.git ~/.oh-my-zsh/plugins
```

---

If you are not using Oh My Zsh, clone it anywhere, for example `~/arch-aptstyle`:

```zsh
git clone https://github.com/mroldl001/arch-aptstyle.git ~/arch-aptstyle
```

### Load the Script

If you're using **Oh My Zsh**, add the following to `~/.zshrc`:

```zsh
plugins=(arch-aptstyle)
```

If you already have a plugin list, just add `arch-aptstyle` to it.

---

If you're not using Oh My Zsh, it is recommended to add this to your `~/.zshrc`:

```zsh
source ~/arch-aptstyle/arch-aptstyle.plugin.zsh
```

This makes future plugin management easier, though you can also directly source the `.zsh` file.

### Reload Configuration

```zsh
source ~/.zshrc
```

Now you can manage packages using apt-style commands like `pacmana update`, `yaya remove <pkg>`, or `parua i <pkg>`!

## 📖 Usage Guide

By appending an `a` to Arch-based package managers (`pacman`, `yay`, `paru`) to form `pacmana`, `yaya`, and `parua`, you can enjoy an apt-like experience!

### Command Mapping Table (with Description)

#### 1. Basic Operations

| Subcommand                          | Options        | pacman Command     | yay/paru Command                    | Supported       | Description                     |
| ----------------------------------- | -------------- | ------------------ | ----------------------------------- | --------------- | ------------------------------- |
| `install` / `i`                     |                | `sudo pacman -S`   | `paru/yay -S`                       | ✅ All supported | Install package                 |
| `uninstall` / `remove` / `rm` / `r` |                | `sudo pacman -Rns` | `paru/yay -Rns`                     | ✅ All supported | Completely remove packages      |
| `update` / `upd`                    |                | `sudo pacman -Sy`  | `paru/yay -Sy`                      | ✅ All supported | Update package database         |
| `upgrade` / `upg`                   |                | `sudo pacman -Su`  | `paru/yay -Su`                      | ✅ All supported | Upgrade all packages            |
| `up` / `u` / `Syu`                  |                | `sudo pacman -Syu` | `paru/yay -Syu`                     | ✅ All supported | Update database and all packages, recommended by Arch |
| `search` / `s`                      |                | `pacman -Ss`       | `pacman -Ss` and `paru/yay -Ss --aur` | ✅ All supported | Search for packages             |
| `search` / `s`                      | `--official`   | `pacman -Ss`       | `pacman -Ss`                        | ✅ All supported | Search official packages only   |
| `search` / `s`                      | `--aur`        | *Not Supported*    | `paru/yay -Ss --aur`                | ❌ pacman not supported | Search AUR packages only     |

---

#### 2. Package Information Queries

| Subcommand         | Options         | pacman Command  | yay/paru Command     | Supported       | Description                     |
| ------------------ | --------------- | -------------- | -------------------- | --------------- | ------------------------------- |
| `show`             |                 | `pacman -Si`   | `paru/yay -Si`       | ✅ All supported | Show package information        |
| `show`             | `--installed`   | `pacman -Qi`   | `paru/yay -Qi`       | ✅ All supported | Show installed package info     |
| `show`             | `--aur`         | *Not Supported* | `paru/yay -Si --aur` | ❌ pacman not supported | Show AUR package info     |
| `list` / `ls`      |                 | `pacman -Q`    | `paru/yay -Q`        | ✅ All supported | List all packages               |
| `list` / `ls`      | `--upgradable`  | `pacman -Qu`   | `paru/yay -Qu`       | ✅ All supported | List upgradable packages        |
| `list` / `ls`      | `--installed`   | `pacman -Q`    | `paru/yay -Q`        | ✅ All supported | List installed packages (excluding upgradable) |
| `list` / `ls`      | `--unofficial`  | `paru/yay -Qm` | `paru/yay -Qm`       | ✅ All supported | List unofficial packages        |
| `orphan` / `orphans` |               | `pacman -Qtd`  | `paru/yay -Qtd`      | ✅ All supported | List orphan packages            |

---

#### 3. System Maintenance

| Subcommand           | Options | pacman Command     | yay/paru Command | Supported   | Description                            |
| ------------------- | ------- | ---------------- | ---------------- | ------- | -------------------------------------- |
| `clean` / `c`       |         | `sudo pacman -Sc` | `paru/yay -Sc`   | ✅ All supported | Clean cache packages                   |
| `autoremove` / `ar` |         | *uses pacman -Rns* | *uses paru/yay -Rns* | ✅ All supported | Auto-remove orphans *(use cautiously)* |
| `check` / `ck`      |         | `pacman -Qk`     | `paru/yay -Qk`   | ✅ All supported | Check package integrity                |

---

#### 4. Other Operations

| Subcommand               | Options | pacman Command       | yay/paru Command       | Supported   | Description |
| ------------------------ | ------- | --------------- | ----------------- | ------- | ----------- |
| `download` / `dl`        |         | `sudo pacman -Sw`    | `paru/yay -Sw`    | ✅ All supported | Download only |
| `help` / `-h` / `--help` |         | `pacman --help` | `paru/yay --help` | ✅ All supported | Show help   |

> [!IMPORTANT]
> - Subcommands not listed above will be passed through to the original command
> - `sudo` is automatically added for pacman commands that require root; please do not manually add `sudo`
> - `yaya` and `parua` commands depend on their respective package managers (without the trailing `a`) being installed
> - ~~Both `update` and `upgrade` were wrappers for `--Syu`, and you could use either command to update all packages from official repositories~~
> - Now, `update` and `upgrade` are decoupled, allowing you to separate updating the package database from upgrading packages
> - `up`, `u`, and `Syu` all wrap `--Syu`, and you can use any of these commands to update all packages
> - list and search may have bugs, please report any issues you encounter

### Common Prompts and How to Handle

| Message                                                                   | Solution                                                            |
| ------------------------------------------------------------------------- | ------------------------------------------------------------------- |
| `[E] arch-aptstyle:'pacman' not found. Please use an Arch-based system.`  | This plugin is designed for Arch-based distros; if `pacman` is not found, you're probably using a different distribution |
| `[E] arch-aptstyle: ... does not support ... `                            | Your package manager doesn't support this operation; switch managers or use a different command |
| `[I] arch-aptstyle:No orphan packages to remove.`                         | No orphan packages found; no cleanup needed                         |
| `[E] arch-aptstyle: ... autoremove failed.`                               | Please report via issue                                             |
| `[E] arch-aptstyle: missing arguments. Usage: <tool> <command> [args...]` | Missing subcommand; refer to the **Command Mapping Table**          |
| `[E] arch-aptstyle:list: unknown option ...` | Unknown option; refer to the **Command Mapping Table** | 
| `[E] arch-aptstyle: Cannot specify both options at the same time.` | Please do not use multiple options simultaneously |

## 🗒️ Changelog

- dev2025527-0008: (Starting to track changes from this version, as it's the first dev version I consider usable)✨♻️🔥

    - Decoupled update and upgrade
    - Removed diff and why subcommands
    - Renamed info subcommand to show for consistency with apt
    - Refactored show, list, search subcommands for better usability
    - Refactored some code implementation approaches

- dev20250527-0051: 🐛

    - Fixed various bugs in the search subcommand

- dev20250527-0147: ✨🐛♻️

    - Fixed various bugs in the list subcommand
    - Added new --unofficial option to list subcommand for listing all unofficial local packages
    - Refactored multi-option handling and flag variable naming for consistency

- dev2025527-0205: 🐛

    - Fixed various bugs in clean and download subcommands

- dev20250527-0217: 🐛

    - Fixed various bugs in update and upgrade subcommands

- **v1.0.0-BakaTesutoShokanju**(dev20250527-0229): 🐛♻️🚀

    - Refactored show subcommand's multi-option logic
    - Fixed some minor bugs
    - Now ready for official release

- **v1.0.1-BakaTesutoShokanju**(dev20250527-accumulate): 📝

    - Significantly updated README
    - Added a brand new project logo

- dev20250606-1340: ✨

    - Added new subcommands up (u | Syu), equivalent to -Syu for updating both package database and packages

- dev20250607-1000: ♻️🐛⚡📝

    - Extracted common logic into helper function __aas_run()
    - Fixed bug where u/up/Syu subcommands incorrectly used -Su for yay/paru
    - Simplified redundant code in show subcommand
    - Optimized list subcommand efficiency using associative arrays instead of nested loops
    - Fixed inconsistent indentation
    - Fixed several minor bugs in README

- dev20260510-0516: 🐛

    - Fixed issue #5: pacmana commands would show non-root error when command failed
    - Fixed __aas_run() function logic to avoid re-running without sudo after sudo command failed

- **v1.1.0-BakaTesutoShokanju**(dev20260510-0516): 🐛♻️⚡📝🚀

    - Extracted common logic into helper function __aas_run()
    - Fixed bug where u/up/Syu subcommands incorrectly used -Su for yay/paru
    - Simplified redundant code in show subcommand
    - Optimized list subcommand efficiency using associative arrays instead of nested loops
    - Fixed inconsistent indentation
    - Fixed several minor bugs in README
    - Fixed issue #5: pacmana commands would show non-root error when command failed
    - Fixed __aas_run() function logic to avoid re-running without sudo after sudo command failed

## ✨ Acknowledgments

- Thanks to [sskka235](https://github.com/sskka235) for testing the `dev` version.
