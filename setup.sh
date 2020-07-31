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
    if [ $(lsb_release -c -s) = "jessie" -o $(lsb_release -c -s) = "stretch" -o $(lsb_release -c -s) = "xenial" ]; then
        wget -O - $BASE_URL/$VERSION_BASE/VESTA-gtk2.tar.bz2 | tar jxf -
        mv -f VESTA-gtk2 dist
    else
        wget -O - $BASE_URL/$VERSION_BASE/VESTA-gtk3.tar.bz2 | tar jxf -
        mv -f VESTA-gtk3 dist
    fi
    ;;
i386)
    wget -O - $BASE_URL/$VERSION_BASE/VESTA-i686.tar.bz2 | tar jxf -
    mv -f VESTA-i686 dist
    rm -rf dist/PowderPlot
    ;;
esac

cp -frp $SCRIPT_DIR/debian $BUILD_DIR
case "$(dpkg --print-architecture)" in
    amd64)
        if [ $(lsb_release -c -s) = "jessie" -o $(lsb_release -c -s) = "stretch" -o $(lsb_release -c -s) = "xenial" ]; then
            cp -frp $SCRIPT_DIR/debian9/* $BUILD_DIR/debian
        fi
        ;;
    i386)
        cp -frp $SCRIPT_DIR/debian32/* $BUILD_DIR/debian
        ;;
esac
cp -frp $SCRIPT_DIR/vesta $SCRIPT_DIR/vesta.desktop $BUILD_DIR

cd $BUILD_DIR
sudo apt-get update
sudo apt-get -y upgrade
dpkg-checkbuilddeps 2>&1 | sed 's/dpkg-checkbuilddeps.*dependencies: //' | xargs sudo apt-get -y install
