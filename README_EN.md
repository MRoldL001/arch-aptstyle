> Translated by ChatGPT, not reviewed.  阅读[简体中文](README.md)版本

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
````

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

#### Basic Operations

| Subcommand                          | pacman Command     | yay/paru Command | Supported | Description                     |
| ----------------------------------- | ------------------ | ---------------- | --------- | ------------------------------- |
| `install` / `i`                     | `sudo pacman -S`   | `paru/yay -S`    | ✅         | Install package                 |
| `uninstall` / `remove` / `rm` / `r` | `sudo pacman -Rns` | `paru/yay -Rns`  | ✅         | Completely remove packages      |
| `update` / `upgrade` / `up` / `u`   | `sudo pacman -Syu` | `paru/yay -Syu`  | ✅         | Update official repository pkgs |
| Above with `--aur`                  | *Not Supported*    | `paru/yay -Syua` | ❌         | Update only AUR packages        |
| `search` / `s`                      | `pacman -Ss`       | `paru/yay -Ss`   | ✅         | Search for packages             |

#### Package Info Queries

| Subcommand         | pacman Command  | yay/paru Command     | Supported | Description                                       |
| ------------------ | --------------- | -------------------- | --------- | ------------------------------------------------- |
| `info`             | `pacman -Si`    | `paru/yay -Si`       | ✅         | Show package information                          |
| Above with `--aur` | *Not Supported* | `paru/yay -Si --aur` | ❌         | Show AUR package info                             |
| `list` / `ls`      | `pacman -Q`     | `paru/yay -Q`        | ✅         | List installed packages (like `list --installed`) |
| Above with `--aur` | *Not Supported* | `paru/yay -Qm`       | ❌         | List AUR-installed packages                       |
| `why`              | `pacman -Qi`    | `paru/yay -Qi`       | ✅         | Show why a package is installed                   |

#### System Maintenance

| Subcommand           | pacman Command  | yay/paru Command | Supported | Description                            |
| -------------------- | --------------- | ---------------- | --------- | -------------------------------------- |
| `clean` / `c`        | *Not Supported* | `paru/yay -Sc`   | ❌         | Clean cache packages                   |
| `orphan` / `orphans` | `pacman -Qtd`   | `paru/yay -Qtd`  | ✅         | List orphan packages                   |
| `autoremove` / `ar`  | `pacman -Rns`   | `paru/yay -Rns`  | ✅         | Auto-remove orphans *(use cautiously)* |
| `check` / `ck`       | `pacman -Qk`    | `paru/yay -Qk`   | ✅         | Check package integrity                |

#### Advanced Operations

| Subcommand        | pacman Command  | yay/paru Command      | Supported | Description       |
| ----------------- | --------------- | --------------------- | --------- | ----------------- |
| `download` / `dl` | *Not Supported* | `paru/yay -Sw`        | ❌         | Download only     |
| `diff`            | *Not Supported* | `paru/yay -Du --diff` | ❌         | Show version diff |

#### Miscellaneous

| Subcommand               | pacman Command  | yay/paru Command  | Supported | Description |
| ------------------------ | --------------- | ----------------- | --------- | ----------- |
| `help` / `-h` / `--help` | `pacman --help` | `paru/yay --help` | ✅         | Show help   |

#### Notes

* Subcommands not listed will be passed through to the original command.
* `sudo` is automatically added for pacman commands that require root; it’s safe to use with or without.
* `yaya` and `parua` depend on the respective tools (`yay`, `paru`) being installed without the `a`.
* `update` and `upgrade` both wrap `--Syu`, updating all packages from official repos.

#### Implementation of `autoremove`

Executes `-Qtdq` to get orphan package names, stores them in a variable `orphans`, and if non-empty, deletes them using the appropriate manager (`sudo` for pacman; none for paru/yay). If empty, displays a tip.

### Common Prompts and How to Handle

| Message                                                                   | Solution                                                              |
| ------------------------------------------------------------------------- | --------------------------------------------------------------------- |
| `[E] arch-aptstyle:'pacman' not found. Please use an Arch-based system.`  | This plugin is designed for Arch-based distros; `pacman` is required. |
| `[E] arch-aptstyle: ... does not support ... `                            | Your manager doesn't support this command.                            |
| `[I] arch-aptstyle:No orphan packages to remove.`                         | No orphan packages found.                                             |
| `[E] arch-aptstyle: ... autoremove failed.`                               | Please report via issue.                                              |
| `[E] arch-aptstyle: missing arguments. Usage: <tool> <command> [args...]` | Missing arguments; refer to the **Command Mapping Table**                     |

## ✨ Acknowledgments

* Thanks to [sskka235](https://github.com/sskka235) for testing the `dev` version.
