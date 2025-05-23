# error message
if [[ -o interactive ]]; then
  if ! command -v pacman >/dev/null 2>&1; then
    echo -e "\033[1;31march-aptstyle:\033[ [E] 'pacman' not found. Please use an Arch-based system." >&2
  fi
fi

# main
paru() {
  case "$1" in
    install|i)
      shift
      command paru -S "$@"
      ;;
    uninstall|remove|rm|r)
      shift
      command paru -Rns "$@"
      ;;
    search|s)
      shift
      command paru -Ss "$@"
      ;;
    update|upgrade|up|u)
      shift
      if [[ "$1" == "-a" || "$1" == "--aur" ]]; then
        shift
        command paru -Syua "$@"
      else
        command paru -Syu "$@"
      fi
      ;;
    clean|c)
      shift
      command paru -Sc "$@"
      ;;
    info|info-aur)
      shift
      if [[ "$1" == "aur" ]]; then
        shift
        command paru -Si --aur "$@"
      else
        command paru -Si "$@"
      fi
      ;;
    list|ls)
      shift
      if [[ "$1" == "aur" ]]; then
        shift
        command paru -Qm "$@"
      else
        command paru -Q "$@"
      fi
      ;;
    orphan|orphans)
      shift
      command paru -Qtd "$@"
      ;;
    autoremove|ar)
      shift
      local orphans
      orphans=$(paru -Qtdq)
      if [[ -n "$orphans" ]]; then
        command paru -Rns $orphans "$@"
      else
        echo "No orphan packages to remove."
      fi
      ;;
    check|ck)
      shift
      command paru -Qk "$@"
      ;;
    download|dl)
      shift
      command paru -Sw "$@"
      ;;
    diff)
      shift
      command paru -Du --diff "$@"
      ;;
    why)
      shift
      command paru -Qi "$@"
      ;;
    help|-h|--help)
      command paru --help
      ;;
    *)
      command paru "$@"
      ;;
  esac
}

yay() {
  case "$1" in
    install|i)
      shift
      command yay -S "$@"
      ;;
    uninstall|remove|rm|r)
      shift
      command yay -Rns "$@"
      ;;
    search|s)
      shift
      command yay -Ss "$@"
      ;;
    update|upgrade|up|u)
      shift
      if [[ "$1" == "-a" || "$1" == "--aur" ]]; then
        shift
        command yay -Syua "$@"
      else
        command yay -Syu "$@"
      fi
      ;;
    clean|c)
      shift
      command yay -Sc "$@"
      ;;
    info|info-aur)
      shift
      if [[ "$1" == "aur" ]]; then
        shift
        command yay -Si --aur "$@"
      else
        command yay -Si "$@"
      fi
      ;;
    list|ls)
      shift
      if [[ "$1" == "aur" ]]; then
        shift
        command yay -Qm "$@"
      else
        command yay -Q "$@"
      fi
      ;;
    orphan|orphans)
      shift
      command yay -Qtd "$@"
      ;;
    autoremove|ar)
      shift
      local orphans
      orphans=$(yay -Qtdq)
      if [[ -n "$orphans" ]]; then
        command yay -Rns $orphans "$@"
      else
        echo "No orphan packages to remove."
      fi
      ;;
    check|ck)
      shift
      command yay -Qk "$@"
      ;;
    download|dl)
      shift
      command yay -Sw "$@"
      ;;
    diff)
      shift
      command yay -Du --diff "$@"
      ;;
    why)
      shift
      command yay -Qi "$@"
      ;;
    help|-h|--help)
      command yay --help
      ;;
    *)
      command yay "$@"
      ;;
  esac
}

pacman() {
  case "$1" in
    install|i)
      shift
      sudo pacman -S "$@"
      ;;
    uninstall|remove|rm|r)
      shift
      sudo pacman -Rns "$@"
      ;;
    search|s)
      shift
      pacman -Ss "$@"
      ;;
    update|upgrade|up|u)
      sudo pacman -Syu
      ;;
    clean|c)
      echo "pacman does not support the clean operation."
      ;;
    info|info-aur)
      shift
      pacman -Si "$@"
      ;;
    list|ls)
      shift
      pacman -Q "$@"
      ;;
    orphan|orphans)
      shift
      pacman -Qtd "$@"
      ;;
    autoremove|ar)
      shift
      local orphans
      orphans=$(pacman -Qtdq)
      if [[ -n "$orphans" ]]; then
        sudo pacman -Rns $orphans "$@"
      else
        echo "No orphan packages to remove."
      fi
      ;;
    check|ck)
      shift
      pacman -Qk "$@"
      ;;
    download|dl)
      echo "pacman does not support the download operation."
      ;;
    diff)
      echo "pacman does not support the diff operation."
      ;;
    why)
      shift
      pacman -Qi "$@"
      ;;
    help|-h|--help)
      pacman --help
      ;;
    *)
      pacman "$@"
      ;;
  esac
}

