# version
aas_version = "2025526-2003"

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
      local aur_flag=false
      while [[ $# -gt 0 ]]; do
        case "$1" in
          --aur)
            aur_flag=true
            shift
            ;;
          *)
            break
            ;;
        esac
      done

      if $aur_flag; then
        "$tool" -Syua "$@"
      else
        [[ "$tool" == "pacman" ]] && sudo "$tool" -Syu "$@" || "$tool" -Syu "$@"
      fi
      ;;
    clean|c)
      if [[ "$tool" == "pacman" ]]; then
        echo -e "\033[1;31m[E] arch-aptstyle:$tool does not support the clean operation.\033[0m" >&2
        return 1
      fi
      "$tool" -Sc "$@"
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

      if $installed_flag && $aur_flag; then
        echo -e "\033[1;31m[E] arch-aptstyle: Cannot specify both --installed and --aur simultaneously.\033[0m" >&2
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
      local aur_flag=false official_flag=false all_flag=false
      local packages=()
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
          --all)
            all_flag=true
            shift
            ;;
          -*)
            echo -e "\033[1;31m[E] arch-aptstyle:list: unknown option '$1'\033[0m" >&2
            return 1
            ;;
          *)
            packages+=("$1")
            shift
            ;;
        esac
      done

      if (( aur_flag + official_flag + all_flag > 1 )); then
        echo -e "\033[1;31m[E] arch-aptstyle: Cannot specify more than one of --aur, --official, or --all simultaneously.\033[0m" >&2
        return 1
      elif $aur_flag; then
        if [[ "$tool" == "pacman" ]]; then
          echo -e "\033[1;31m[E] arch-aptstyle:$tool does not support '--aur'.\033[0m" >&2
          return 1
        fi
        if [[ ${#packages[@]} -eq 0 ]]; then
          "$tool" -Slq --aur | awk '{print "[AUR] " $0}'
        else
          for pkg in "${packages[@]}"; do
            "$tool" -Ss "$pkg" | awk '{print "[AUR] " $0}'
          done
        fi
      elif $official_flag; then
        if [[ ${#packages[@]} -eq 0 ]]; then
          pacman -Slq | awk '{print "[official] " $0}'
        else
          pacman -Ss "${packages[@]}" | awk '{print "[official] " $0}'
        fi
      elif $all_flag; then
        if [[ ${#packages[@]} -eq 0 ]]; then
          pacman -Slq | awk '{print "[official] " $0}'
          if [[ "$tool" != "pacman" ]]; then
            "$tool" -Slq --aur | awk '{print "[AUR] " $0}'
          fi
        else
          pacman -Ss "${packages[@]}" | awk '{print "[official] " $0}'
          if [[ "$tool" != "pacman" ]]; then
            for pkg in "${packages[@]}"; do
              "$tool" -Ss "$pkg" | awk '{print "[AUR] " $0}'
            done
          fi
        fi
      else
        if [[ ${#packages[@]} -eq 0 ]]; then
          "$tool" -Q | awk '{print "[local] " $0}'
        else
          for pkg in "${packages[@]}"; do
            "$tool" -Q "$pkg" | awk '{print "[local] " $0}'
          done
        fi
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

