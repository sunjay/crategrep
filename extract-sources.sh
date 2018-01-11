#!/usr/bin/env bash

# This is a separate script so that you can extract the sources you already have
# downloaded. Cancelling the downloading and then using this script separately
# can be a big time saver if you aren't actually deploying the app.

set -e

CRATES_MIRROR="crates-mirror"

echo -e "\nExtracting all crate source code..."
for crate in $(ls $CRATES_MIRROR/*.crate); do
  # This mostly works, but not always since the casing of some crate names don't
  # match the directory within them
  if [ ! -d "$CRATES_MIRROR/$(basename $crate .crate)" ]; then
    echo "Extracting source in $crate...";
    tar xvzf $crate --directory $CRATES_MIRROR;
  else
    echo "Not extracting source in $crate. It is already extracted."
  fi
done
