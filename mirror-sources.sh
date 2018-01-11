#!/usr/bin/env bash

set -e

CRATES_MIRROR="crates-mirror"

if [ ! -d "$CRATES_MIRROR/index" ]; then
  echo "Freshly cloning crates.io index..."
  rm -rf $CRATES_MIRROR/index/
  git clone https://github.com/rust-lang/crates.io-index.git $CRATES_MIRROR/index
else
  echo "Pulling latest crates.io index..."
  cd $CRATES_MIRROR/index
  git reset --hard HEAD
  git clean -f -d
  git pull
  cd -
fi

# These next steps take a while because we are literally downloading and
# extracting the source of EVERY crate on crates.io

if ! [ -x "$(command -v crates-ectype)" ]; then
  echo "Installing crates-ectype..."
  cargo install --git https://github.com/C4K3/crates-ectype
fi

# If this gets interrupted, it will not start from the beginning
echo -e "\nDownloading all crates... (this will take a while)"
crates-ectype $CRATES_MIRROR/ --no-update-index

./extract-sources.sh
