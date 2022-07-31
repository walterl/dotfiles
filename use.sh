#!/usr/bin/env zsh

# Stolen and customized from
# https://github.com/sheerun/dotfiles/blob/master/bin/dotfiles.

set -E

e_header()  { echo -e "\n\033[1m$@\033[0m"; }
e_success() { echo -e " \033[1;32m✔\033[0m  $@"; }
e_error()   { echo -e " \033[1;31m✖\033[0m  $@"; }
e_arrow()   { echo -e " \033[1;33m➜\033[0m  $@"; }

DOTHOME=$(echo $(cd "`dirname $0`" && pwd -P))
BACKDIR="$DOTHOME/backup/dotfiles/$(date "+%Y_%m_%d-%H_%M_%S")"
THISFILE=$DOTHOME/$(basename $0)
UNLINK=
if [ "$1" = "-r" ]; then
  UNLINK=1
fi

run() {
  if [ -n "$UNLINK" ]; then
    e_header "Unlinking files from home directory..."
    unlink_dotfiles
  else
    e_header "Linking files into home directory..."
    link_dotfiles
    e_header "Performing post-link initializations..."
    post_link_cmds
    e_header "Loading dconf configs..."
    load_dconf
  fi
  print_messages
}

link_dotfiles() {
  mklink "bashrc"
  mklink "dircolors"
  mklink "gitconfig"
  mklink "gitexcludes"
  mklink "oh-my-zsh"
  mklink "startup.py" # Controlled by $PYTHONSTARTUP
  mklink "tmux.conf"
  mklink "vimrc"
  mklink "zshrc"

  mklink "_config/alacritty" ".config"
  mklink "_config/nvim" ".config"
  mklink "_config/starship.toml" ".config"
  mklink "_config/terminator" ".config"

  mklink "_fonts/DejaVu Sans Mono for Powerline.ttf" ".fonts"
  mklink "_fonts/DejaVu Sans Mono Bold for Powerline.ttf" ".fonts"
  mklink "_fonts/DejaVu Sans Mono Bold Oblique for Powerline.ttf" ".fonts"
  mklink "_fonts/DejaVu Sans Mono Oblique for Powerline.ttf" ".fonts"
  mklink "_fonts/PowerlineSymbols.otf" ".fonts"
}

unlink_dotfiles() {
  rmlink "bashrc"
  rmlink "dircolors"
  rmlink "gitconfig"
  rmlink "gitexcludes"
  rmlink "oh-my-zsh"
  rmlink "startup.py" # Controlled by $PYTHONSTARTUP
  rmlink "tmux.conf"
  rmlink "vimrc"
  rmlink "zshrc"

  rmlink "_config/alacritty" ".config"
  rmlink "_config/nvim" ".config"
  rmlink "_config/starship.toml" ".config"
  rmlink "_config/terminator" ".config"

  rmlink "_fonts/DejaVu Sans Mono for Powerline.ttf" ".fonts"
  rmlink "_fonts/DejaVu Sans Mono Bold for Powerline.ttf" ".fonts"
  rmlink "_fonts/DejaVu Sans Mono Bold Oblique for Powerline.ttf" ".fonts"
  rmlink "_fonts/DejaVu Sans Mono Oblique for Powerline.ttf" ".fonts"
  rmlink "_fonts/PowerlineSymbols.otf" ".fonts"
}

mklink() {
  local file="$DOTHOME/$1"
  local reldestdir="$2"
  local backdir="$BACKDIR/$2"

  if [ -n "$reldestdir" ]; then
    destdir="$HOME/$reldestdir"
    [ ! -d "$destdir" ] && mkdir -p "$destdir"
  else
    destdir="$HOME"
  fi

  [[ "$destdir" == "$HOME" ]] && local prefix="." || local prefix=""

  cd "$destdir"
  local base="$(basename $file)"
  local dest="$destdir/$prefix$base"
  [ -n "$reldestdir" ] && local reldest="$reldestdir/$prefix$base" || local reldest="$prefix$base"

  # Skip if $file refers to this file.
  if test "$file" -ef "$THISFILE"; then
    return
  fi

  # Skip if link is the same.
  if test "$file" -ef "$dest"; then
    e_arrow "$reldest [already exists]"
    return
  fi

  # Back up file if it exists.
  if [[ -e "$dest" ]]; then
    e_arrow "Backing up $reldest."
    inform_about_backup=1
    mkdir -p "$backdir"
    mv "$dest" "$backdir"
  fi

  ln -sf "${file}" "$dest"
  e_success "$reldest"
}

rmlink() {
  local file="$DOTHOME/$1"
  local reldestdir="$2"

  if [ -n "$reldestdir" ]; then
    destdir="$HOME/$reldestdir"
    [ ! -d "$destdir" ] && mkdir -p "$destdir"
  else
    destdir="$HOME"
  fi

  [[ "$destdir" == "$HOME" ]] && local prefix="." || local prefix=""

  local base="$(basename $file)"
  local dest="$destdir/$prefix$base"
  [ -n "$reldestdir" ] && local reldest="$reldestdir/$prefix$base" || local reldest="$prefix$base"

  if [ ! -L "$dest" -o "$(readlink -f "$dest")" != "$file" ]; then
    e_arrow "$reldest [skipped]"
    return
  fi

  rm "$dest"
  e_error "$reldest"
}

post_link_cmds() {
  if command -v nvim > /dev/null; then
    nvim +PlugInstall +qa
    e_success "nvim +PlugInstall +qa"
  fi
}

load_dconf() {
  dconf load /apps/guake/ < dconf/guake.dconf
}

print_messages() {
  if [[ $inform_about_backup == 1 ]]; then
    echo "\nBackups were moved to $BACKDIR\n"
  fi
}

(run)
