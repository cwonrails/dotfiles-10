#!/bin/bash
set -euf
# shellcheck source=helpers.sh
source "$HOME/dotfiles/scripts/helpers.sh"

if ! command -v apt-get &> /dev/null; then
  echo "$XMARK Non-debian not supported"
  exit 1
fi

if ! command -v lpass > /dev/null; then
  echo "$ARROW Installing build dependencies (requires sudo)"
  installAptPackagesIfMissing cmake openssl libcurl3 libxml2 libxml2-dev \
    libcurl4-openssl-dev pkg-config pinentry-curses

  LOCAL_DIR=$HOME/.local

  SOURCE_DIR="$LOCAL_DIR/source/lastpass-cli"
  if [ ! -d "$SOURCE_DIR" ]; then
    echo "$ARROW Cloning repository"
    git clone https://github.com/lastpass/lastpass-cli.git "$SOURCE_DIR"
    pushd "$SOURCE_DIR" > /dev/null
  else
    pushd "$SOURCE_DIR" > /dev/null
    echo "$ARROW Pulling repository for latest"
    git pull
  fi

  cmake .
  # Install everything locally so we don't need sudo
  cmake -DCMAKE_INSTALL_PREFIX="$LOCAL_DIR" \
    -DBASH_COMPLETION_COMPLETIONSDIR="$LOCAL_DIR/completions.d"
  make && make install
  popd > /dev/null
fi

echo "$CMARK lpass installed"
