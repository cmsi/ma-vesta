#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0) && pwd)
PACKAGE=$(echo $(basename $SCRIPT_DIR) | sed 's/ma-//g')
VERSION=$(head -1 $SCRIPT_DIR/debian/changelog | cut -d ' ' -f 2 | sed 's/[()]//g')
VERSION_BASE=$(echo $VERSION | cut -d '-' -f 1)

echo "PACKAGE: $PACKAGE"
echo "VERSION: $VERSION"
echo "VERSION_BASE: $VERSION_BASE"
echo "SCRIPT_DIR: $SCRIPT_DIR"

if [ $(lsb_release -s -i) = 'Debian' ]; then
  BUILD_DIR="$HOME/build/${PACKAGE}_${VERSION_BASE}"
  TARGET_DIR="$HOME/data/pkg/$(lsb_release -s -c)"
  DATA_DIR="$HOME/data/src"
  echo "BUILD_DIR: $BUILD_DIR"
  echo "TARGET_DIR: $TARGET_DIR"
  echo "DATA_DIR: $DATA_DIR"
fi
