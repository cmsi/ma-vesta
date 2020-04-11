#!/bin/sh
. $(dirname $0)/path.sh
test -z $BUILD_DIR && exit 127

rm -rf $BUILD_DIR
set -x

mkdir -p $BUILD_DIR
cd $BUILD_DIR
BASE_URL=https://jp-minerals.org/vesta/archives
if [ $(lsb_release -c -s) = "jessie" -o $(lsb_release -c -s) = "stretch" -o $(lsb_release -c -s) = "xenial" ]; then
    case "$(dpkg --print-architecture)" in
        amd64)
            wget -O - $BASE_URL/$VERSION_BASE/VESTA-gtk2.tar.bz2 | tar jxf -
            mv -f VESTA-gtk2 dist
            ;;
        i386)
            echo "32bit OS is not supported"
            exit 127
            ;;
    esac
    cp -frp $SCRIPT_DIR/debian $BUILD_DIR
    cp -frp $SCRIPT_DIR/debian9/* $BUILD_DIR/debian
    cp -frp $SCRIPT_DIR/vesta $SCRIPT_DIR/vesta.desktop $BUILD_DIR
else
    case "$(dpkg --print-architecture)" in
        amd64)
            wget -O - $BASE_URL/$VERSION_BASE/VESTA-gtk3.tar.bz2 | tar jxf -
            mv -f VESTA-gtk3 dist
            ;;
        i386)
            echo "32bit OS is not supported"
            exit 127
            ;;
    esac
    cp -frp $SCRIPT_DIR/debian $BUILD_DIR
    cp -frp $SCRIPT_DIR/vesta $SCRIPT_DIR/vesta.desktop $BUILD_DIR
fi

cd $BUILD_DIR
sudo apt-get update
sudo apt-get -y upgrade
dpkg-checkbuilddeps 2>&1 | sed 's/dpkg-checkbuilddeps.*dependencies: //' | xargs sudo apt-get -y install
