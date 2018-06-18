#!/bin/sh
. $(dirname $0)/path.sh
test -z $BUILD_DIR && exit 127

mkdir -p $TARGET_DIR
cd $BUILD_DIR 
case "$(dpkg --print-architecture)" in
    amd64)
        dpkg-buildpackage -us -uc
        awk '$3!="debug" {print}' ../${PACKAGE}_${VERSION}_amd64.changes > $TARGET_DIR/${PACKAGE}_${VERSION}_amd64.changes
        mv -f ../${PACKAGE}*_${VERSION_BASE}*.buildinfo ../${PACKAGE}*_${VERSION_BASE}*.deb $TARGET_DIR
        mv -f ../${PACKAGE}*_${VERSION_BASE}*.dsc ../${PACKAGE}*_${VERSION_BASE}*.debian.tar.* $TARGET_DIR
        cp -f ../${PACKAGE}*_${VERSION_BASE}*.orig.tar.gz $TARGET_DIR
        ;;
    i386)
        dpkg-buildpackage -B -us -uc
        awk '$3!="debug" {print}' ../${PACKAGE}_${VERSION}_i386.changes > $TARGET_DIR/${PACKAGE}_${VERSION}_i386.changes
        mv -f ../${PACKAGE}*_${VERSION_BASE}*.buildinfo ../${PACKAGE}*_$VERSION_BASE*.deb $TARGET_DIR
        ;;
esac
