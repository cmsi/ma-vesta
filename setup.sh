#!/bin/sh
. $(dirname $0)/path.sh
test -z $BUILD_DIR && exit 127

rm -rf $BUILD_DIR
set -x

mkdir -p $BUILD_DIR
cd $BUILD_DIR
BASE_URL=http://www.geocities.jp/kmo_mma/crystal/download
case "$(dpkg --print-architecture)" in
    amd64)
        wget -O - $BASE_URL/VESTA-x86_64.tar.bz2 | tar jxf -
        mv -f VESTA-x86_64 dist
        ;;
    i386)
        wget -O - $BASE_URL/VESTA-i686.tar.bz2 | tar jxf -
        mv -f VESTA-i686 dist
        ;;
esac
cp -frp $SCRIPT_DIR/debian $SCRIPT_DIR/vesta $SCRIPT_DIR/vesta.desktop $BUILD_DIR
if test $(lsb_release -c -s) = "stretch"; then
    cp -frp $SCRIPT_DIR/$(dpkg --print-architecture)/libpng12.so.0 $BUILD_DIR/dist
fi
