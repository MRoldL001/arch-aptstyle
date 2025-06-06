#!/usr/bin/env zsh

# version
aas_version="v1.0.0-BakaTesutoShokanju(dev20250527-0229)"

# error message
if [[ $- == *i* ]]; then
  if ! command -v pacman >/dev/null 2>&1; then
    echo -e "\033[1;31m[E] arch-aptstyle:'pacman' not found. Please use an Arch-based system.\033[0m" >&2
  fi
fi

# main function
__arch_aptstyle() {
  if [[ $# -lt 2 ]]; then
    echo -e "\033[1;31m[E] arch-aptstyle: missing arguments. Usage: <tool> <command> [args...]\033[0m" >&2
    return 1
  fi
  local tool="$1" cmd="$2"
  shift 2

  case "$cmd" in
    install|i)
      [[ "$tool" == "pacman" ]] && sudo "$tool" -S "$@" || "$tool" -S "$@"
      ;;
    uninstall|remove|rm|r)
      [[ "$tool" == "pacman" ]] && sudo "$tool" -Rns "$@" || "$tool" -Rns "$@"
      ;;
    search|s)
      local aur_flag=false official_flag=false
      while [[ $# -gt 0 ]]; do
        case "$1" in
          --aur)
            aur_flag=true
            shift
            ;;
          --official)
            official_flag=true
            shift
            ;;
          -*)
            echo -e "\033[1;31m[E] arch-aptstyle:search: unknown option '$1'\033[0m" >&2
            return 1
            ;;
          *)
            break
            ;;
        esac
      done

      if (( aur_flag + official_flag > 1 )); then
        echo -e "\033[1;31m[E] arch-aptstyle: Cannot specify both options at the same time.\033[0m" >&2
        return 1
      elif $aur_flag; then
        if [[ "$tool" == "pacman" ]]; then
          echo -e "\033[1;31m[E] arch-aptstyle:$tool does not support '--aur'.\033[0m" >&2
          return 1
        fi
        "$tool" -Ss --aur "$@" | awk '{print "[AUR] " $0}'
      elif $official_flag; then
        pacman -Ss "$@" | awk '{print "[OFFICIAL] " $0}'
      else
        pacman -Ss "$@" | awk '{print "[OFFICIAL] " $0}'
        if [[ "$tool" != "pacman" ]]; then
          "$tool" -Ss --aur "$@" | awk '{print "[AUR] " $0}'
        fi
      fi
      ;;
      
    update|upd)
      [[ "$tool" == "pacman" ]] && sudo "$tool" -Sy "$@" || "$tool" -Sy "$@"
      ;;

    upgrade|upg)
      [[ "$tool" == "pacman" ]] && sudo "$tool" -Su "$@" || "$tool" -Su "$@"
      ;;

    u|up|Syu)
      [[ "$tool" == "pacman" ]] && sudo "$tool" -Syu "$@" || "$tool" -Su "$@"
      ;;

    clean|c)
      [[ "$tool" == "pacman" ]] && sudo "$tool" -Sc "$@" || "$tool" -Sc "$@"
      ;;

    show)
      local installed_flag=false aur_flag=false
      while [[ $# -gt 0 ]]; do
        case "$1" in
          --installed)
            installed_flag=true
            shift
            ;;
          --aur)
            aur_flag=true
            shift
            ;;
          *)
            break
            ;;
        esac
      done

      if (( installed_flag + aur_flag > 1 )); then
          echo -e "\033[1;31m[E] arch-aptstyle: Cannot specify both options at the same time.\033[0m" >&2
        return 1
      elif $installed_flag; then
        if [[ "$tool" == "pacman" ]]; then
          "$tool" -Qi "$@"
        else
          "$tool" -Qi "$@"
        fi
      elif $aur_flag; then
        if [[ "$tool" == "pacman" ]]; then
          echo -e "\033[1;31m[E] arch-aptstyle:$tool does not support '--aur'.\033[0m" >&2
          return 1
        fi
        "$tool" -Si --aur "$@"
      else
        "$tool" -Si "$@"
      fi
      ;;
    list|ls)
      local upgradable_flag=false installed_flag=false unofficial_flag=false
      while [[ $# -gt 0 ]]; do
        case "$1" in
        --upgradable)
          upgradable_flag=true
          shift
          ;;
        --installed)
          installed_flag=true
          shift
        ;;
        --unofficial)
          unofficial_flag=true
          shift
        ;;
        -*)
          echo -e "\033[1;31m[E] arch-aptstyle:list: unknown option '$1'\033[0m" >&2
          return 1
        ;;
        *)
          break
        ;;
        esac
      done

      if (( upgradable_flag + installed_flag + unofficial_flag > 1 )); then
        echo -e "\033[1;31m[E] arch-aptstyle: Cannot specify both options at the same time.\033[0m" >&2
        return 1
      elif $unofficial_flag; then
        "$tool" -Qm "$@"
      else
        local upgradable_packages=()
        upgradable_packages=("${(@f)$("$tool" -Qu)}")

        for package in $($tool -Q); do
          pkg_name=$(echo "$package" | awk '{print $1}')
          pkg_version=$(echo "$package" | awk '{print $2}')
          is_upgradable=false

          for upgradable_package in "${upgradable_packages[@]}"; do
            upgradable_pkg_name=$(echo "$upgradable_package" | awk '{print $1}')
            if [[ "$pkg_name" == "$upgradable_pkg_name" ]]; then
              is_upgradable=true
              break
            fi
        done

        if $upgradable_flag && ! $is_upgradable; then
          continue
        fi

        if $installed_flag && $is_upgradable; then
          continue
        fi

        echo "$pkg_name $pkg_version"
      done
    fi
    ;;
    orphan|orphans)
      "$tool" -Qtd "$@"
      ;;
    autoremove|ar)
      local orphans
      orphans=("${(@f)$("$tool" -Qtdq)}")
      if (( ${#orphans[@]} > 0 )); then
        if [[ "$tool" == "pacman" ]]; then
          sudo "$tool" -Rns "${orphans[@]}" "$@"
          local ret=$?
          if [[ $ret -ne 0 ]]; then
            echo -e "\033[1;31m[E] arch-aptstyle:$tool autoremove failed.\033[0m" >&2
            return $ret
          fi
        else
          "$tool" -Rns "${orphans[@]}" "$@"
        fi
      else
        echo -e "\033[1;32m[I] arch-aptstyle: No orphan packages to remove.\033[0m"
      fi
      ;;
    check|ck)
      "$tool" -Qk "$@"
      ;;
    download|dl)
      [[ "$tool" == "pacman" ]] && sudo "$tool" -Sw "$@" || "$tool" -Sw "$@"
      ;;
    help|-h|--help)
      "$tool" --help
      ;;
    *)
      "$tool" "$cmd" "$@"
      ;;
  esac
}

# aliases
parua()   { __arch_aptstyle paru "$@"; }
yaya()    { __arch_aptstyle yay "$@"; }
pacmana() { __arch_aptstyle pacman "$@"; }

