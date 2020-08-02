#!/usr/bin/env zsh

# Stolen and customized from
# https://github.com/sheerun/dotfiles/blob/master/bin/dotfiles.

set -E

e_header()   { echo -e "\n\033[1m$@\033[0m"; }
e_success()  { echo -e " \033[1;32m✔\033[0m  $@"; }
e_error()    { echo -e " \033[1;31m✖\033[0m  $@"; }
e_arrow()    { echo -e " \033[1;33m➜\033[0m  $@"; }

DOTHOME=$(echo $(cd "`dirname $0`" && pwd -P))
BACKDIR="$DOTHOME/backup/dotfiles/$(date "+%Y_%m_%d-%H_%M_%S")/"
THISFILE=$DOTHOME/$(basename $0)
UNLINK=
if [ "$1" = "-r" ]; then
  UNLINK=1
fi

run() {
  if [ -n "$UNLINK" ]; then
    unlink_dotfiles
  else
    e_header "Linking files into home directory..."
    link_dotfiles
    link_subdir_files
    post_link_cmds
  fi
  print_messages
}

link_subdir_files() {
  for subdir in $DOTHOME/_*; do
    [ -d $subdir ] || continue # Only process sub-dirs (not files)
    local dest="$HOME/${${${subdir#$DOTHOME}/_/.}/#\//}"
    [ -d $dest ] || mkdir -p $dest
    link_dotfiles $subdir $dest "" "$BACKDIR/$dest"
  done
}

link_dotfiles() {
  local srcdir=${1:-$DOTHOME}
  local destdir=${2:-$HOME}
  local backdir=${3:-$BACKDIR}
  if [[ "$destdir" == "$HOME" ]]; then
    local prefix="."
  else
    local prefix=""
  fi

  cd "$destdir"
  for file in $srcdir/[a-zA-Z]*; do
    local base="$(basename $file)"
    local dest="$destdir/$prefix$base"

    # Skip if $file refers to this file.
    if test "$file" -ef "$THISFILE"; then
      continue
    fi

    # Skip if link is the same.
    if test "$file" -ef "$dest"; then
      e_success "$base"
      continue
    fi

    # Back up file if it exists.
    if [[ -e "$dest" ]]; then
      e_arrow "Backing up $destdir/$base."
      inform_about_backup=1
      mkdir -p "$BACKDIR"
      mv "$dest" "$BACKDIR"
    fi

    ln -sf "${file}" "$dest"
    e_success "$base"
  done
}

post_link_cmds() {
  e_header "Performing post-link initializations..."
  if command -v nvim; then
    nvim +PlugInstall +qa
    e_success "nvim +PlugInstall +qa"
  fi
}

unlink_dotfiles() {
  e_header "Unlinking files from home directory..."

  cd "$HOME"
  for file in $DOTHOME/[a-zA-Z]*; do
    local base="$(basename $file)"
    local dest="$HOME/.$base"

    if [ ! -L $dest -o $(readlink -f $dest) != $file ]; then
      continue
    fi

    rm "$dest"
    e_error "$base"
  done
}

print_messages() {
  if [[ $inform_about_backup == 1 ]]; then
    echo "\nBackups were moved to $BACKDIR\n"
  fi

  if [[ $first_run == 1 ]]; then
    echo "\nInstallation complete! You can relogin now."
  else
    echo # it's visually better ;)
  fi
}

(run)
