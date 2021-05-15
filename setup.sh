#!/bin/sh
. $(dirname $0)/path.sh
test -z $BUILD_DIR && exit 127

rm -rf $BUILD_DIR
set -x

mkdir -p $BUILD_DIR
cd $BUILD_DIR
BASE_URL=https://jp-minerals.org/vesta/archives

wget -O - $BASE_URL/$VERSION_BASE/VESTA-gtk3.tar.bz2 | tar jxf -
mv -f VESTA-gtk3 dist

cp -frp $SCRIPT_DIR/debian $BUILD_DIR
cp -frp $SCRIPT_DIR/vesta $SCRIPT_DIR/vesta.desktop $BUILD_DIR

cd $BUILD_DIR
sudo apt-get update
sudo apt-get -y upgrade
dpkg-checkbuilddeps 2>&1 | sed 's/dpkg-checkbuilddeps.*dependencies: //' | xargs sudo apt-get -y install
