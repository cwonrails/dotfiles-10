#!/bin/bash
set -ef -o pipefail
# shellcheck source=/home/fortes/dotfiles/scripts/helpers.sh
# shellcheck disable=SC1091
source "$HOME/dotfiles/scripts/helpers.sh"

YARN_SOURCES_FILE=/etc/apt/sources.list.d/yarn.list
if [ ! -f $YARN_SOURCES_FILE ]; then
  echo "$XMARK Yarn not in sources.list"
  echo "  $ARROW Adding yarn to in sources.list (requires sudo)"
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | \
    sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | \
    sudo tee "$YARN_SOURCES_FILE" > /dev/null
  sudo apt-get update -qq
fi
echo "$CMARK Yarn in sources.list"

echo "$ARROW Installing node, npm, and yarn (requires sudo)"
installAptPackagesIfMissing nodejs npm yarn

if ! update-alternatives --get-selections | grep -v -q "^node"; then
  echo "$ARROW Updating alternatives to set symlinks for nodejs to node"
  sudo update-alternatives --install \
    /usr/bin/node node "$(command -v nodejs)" 10
fi
echo "$CMARK Node system alternatives set"

# Create directories for packages
NPM_PREFIX=$HOME/.local
NPM_CACHE_DIR=$HOME/.cache/npm
mkdir -p "$NPM_PREFIX/bin"
mkdir -p "$NPM_CACHE_DIR"

# Cache output since npm list is slow
NODE_PACKAGES=$(npm list -g --depth 0)
PACKAGES=''
for p in $(xargs < "$HOME/dotfiles/scripts/node-packages"); do
  if ! echo "$NODE_PACKAGES" | grep -q "$p@"; then
    echo "$XMARK npm package $p not installed"
    PACKAGES="$PACKAGES $p"
  else
    echo "$CMARK $p installed"
  fi
done

if [ "$PACKAGES" != "" ]; then
  echo "  $ARROW Installing global node packages$PACKAGES"
  # shellcheck disable=SC2086
  npm install -g $PACKAGES
  echo "$CMARK $PACKAGES installed"
fi

echo "$CMARK All node packages installed"
