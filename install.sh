#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="${HOME}/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
DRY_RUN=false
FORCE=false
INSTALL_DEPS=false
INSTALL_OPTIONAL_DEPS=false

usage() {
  cat <<USAGE
Usage: ./install.sh [options]

Options:
  -n, --dry-run   Print actions without changing files
  -f, --force     Replace existing files without creating backups
  -d, --deps      Install required dependencies via Homebrew (macOS)
  -o, --optional  Install optional dependencies via Homebrew (macOS)
  -h, --help      Show this help
USAGE
}

log() {
  printf '%s\n' "$*"
}

run() {
  if [ "$DRY_RUN" = true ]; then
    printf '[dry-run]'
    local arg
    for arg in "$@"; do
      printf ' %q' "$arg"
    done
    printf '\n'
  else
    "$@"
  fi
}

backup_if_needed() {
  local target="$1"
  if [ -e "$target" ] || [ -L "$target" ]; then
    if [ "$FORCE" = true ]; then
      run rm -rf "$target"
      return
    fi

    run mkdir -p "$BACKUP_DIR"
    local base
    base="$(basename "$target")"
    run mv "$target" "$BACKUP_DIR/$base"
    log "Backed up $target -> $BACKUP_DIR/$base"
  fi
}

link_file() {
  local src="$1"
  local dest="$2"

  if [ ! -e "$src" ]; then
    log "Skip: source not found: $src"
    return
  fi

  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    log "Already linked: $dest"
    return
  fi

  backup_if_needed "$dest"
  run mkdir -p "$(dirname "$dest")"
  run ln -sfn "$src" "$dest"
  log "Linked: $dest -> $src"
}

install_deps_with_brew() {
  if [ "$(uname -s)" != "Darwin" ]; then
    log "Skip dependency install (Homebrew flow is macOS only)"
    return
  fi

  if ! command -v brew >/dev/null 2>&1; then
    log "Homebrew not found. Install from https://brew.sh/ and rerun with --deps"
    exit 1
  fi

  local required_packages=(
    git
    neovim
    tmux
    zsh
    ripgrep
    node
    fzf
    lazygit
    delta
  )

  local pkg
  for pkg in "${required_packages[@]}"; do
    run brew install "$pkg"
  done

  if [ "$INSTALL_OPTIONAL_DEPS" = true ]; then
    log "No additional optional Homebrew packages configured."
  fi

  if [ "$INSTALL_OPTIONAL_DEPS" = true ]; then
    log "Dependency install step finished (required + optional)."
  else
    log "Dependency install step finished (required only)."
  fi
}

while [ $# -gt 0 ]; do
  case "$1" in
    -n|--dry-run)
      DRY_RUN=true
      ;;
    -f|--force)
      FORCE=true
      ;;
    -d|--deps)
      INSTALL_DEPS=true
      ;;
    -o|--optional)
      INSTALL_OPTIONAL_DEPS=true
      INSTALL_DEPS=true
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      log "Unknown option: $1"
      usage
      exit 1
      ;;
  esac
  shift
done

log "Dotfiles directory: $DOTFILES_DIR"

if [ "$INSTALL_DEPS" = true ]; then
  install_deps_with_brew
fi

link_file "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/p10k.zsh" "$HOME/.p10k.zsh"
link_file "$DOTFILES_DIR/tmux.conf" "$HOME/.tmux.conf"
link_file "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

if [ "$DRY_RUN" = true ]; then
  log "Dry-run completed."
elif [ "$FORCE" = true ]; then
  log "Install completed (force mode, no backups)."
else
  if [ -d "$BACKUP_DIR" ]; then
    log "Install completed. Backups: $BACKUP_DIR"
  else
    log "Install completed. No backups were needed."
  fi
fi
