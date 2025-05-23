# version: 0.9.0

# error message
if [[ $- == *i* ]]; then
  if ! command -v pacman >/dev/null 2>&1; then
    echo -e "\033[1;31m[E] arch-aptstyle:'pacman' not found. Please use an Arch-based system.\033[0m" >&2
  fi
fi

# main

# general function
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
      "$tool" -Ss "$@"
      ;;
    update|upgrade|up|u)
      if [[ "$1" == "--aur" ]]; then
        shift
        "$tool" -Syua "$@"
      else
        [[ "$tool" == "pacman" ]] && sudo "$tool" -Syu || "$tool" -Syu "$@"
      fi
      ;;
    clean|c)
      if [[ "$tool" == "pacman" ]]; then
        echo -e "\033[1;31m[E] arch-aptstyle:$tool does not support the clean operation.\033[0m" >&2
        return 1
      fi
      "$tool" -Sc "$@"
      ;;
    info)
      if [[ "$1" == "--aur" ]]; then
        shift
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
      if [[ "$1" == "--aur" ]]; then
        shift
        if [[ "$tool" == "pacman" ]]; then
          echo -e "\033[1;31m[E] arch-aptstyle:$tool does not support '--aur'.\033[0m" >&2
          return 1
        fi
        "$tool" -Qm "$@"
      else
        "$tool" -Q "$@"
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
        echo -e "\033[1;32m[I] arch-aptstyle:No orphan packages to remove.\033[0m"
      fi
      ;;
    check|ck)
      "$tool" -Qk "$@"
      ;;
    download|dl)
      if [[ "$tool" == "pacman" ]]; then
        echo -e "\033[1;31m[E] arch-aptstyle:$tool does not support the download operation.\033[0m" >&2
        return 1
      fi
      "$tool" -Sw "$@"
      ;;
    diff)
      if [[ "$tool" == "pacman" ]]; then
        echo -e "\033[1;31m[E] arch-aptstyle:$tool does not support the diff operation.\033[0m" >&2
        return 1
      fi
      "$tool" -Du --diff "$@"
      ;;
    why)
      "$tool" -Qi "$@"
      ;;
    help|-h|--help)
      "$tool" --help
      ;;
    *)
      "$tool" "$cmd" "$@"
      ;;
  esac
}

# main function
parua()   { __arch_aptstyle paru "$@"; }
yaya()    { __arch_aptstyle yay "$@"; }
pacmana() { __arch_aptstyle pacman "$@"; }

