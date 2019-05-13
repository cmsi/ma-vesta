#!/bin/sh
. $(dirname $0)/path.sh
test -z $BUILD_DIR && exit 127

rm -rf $BUILD_DIR
set -x

mkdir -p $BUILD_DIR
cd $BUILD_DIR
BASE_URL=https://jp-minerals.org/vesta/archives
case "$(dpkg --print-architecture)" in
    amd64)
        wget -O - $BASE_URL/$VERSION_BASE/VESTA-x86_64.tar.bz2 | tar jxf -
        mv -f VESTA-x86_64 dist
        ;;
    i386)
        echo "32bit OS is not supported"
        exit 127
        ;;
esac
cp -frp $SCRIPT_DIR/debian $SCRIPT_DIR/vesta $SCRIPT_DIR/vesta.desktop $BUILD_DIR

cd $BUILD_DIR
sudo apt-get update
sudo apt-get -y upgrade
dpkg-checkbuilddeps 2>&1 | sed 's/dpkg-checkbuilddeps.*dependencies: //' | xargs sudo apt-get -y install
