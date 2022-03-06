#!/bin/sh
. $(dirname $0)/path.sh
set -x

mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}
BASE_URL=https://jp-minerals.org/vesta/archives
wget -O - ${BASE_URL}/${VERSION_BASE}/VESTA-gtk3.tar.bz2 | tar jxf -
mv -f VESTA-gtk3 dist

cd ${BUILD_DIR}
mkdir -p debian
cp -rp ${SCRIPT_DIR}/debian/* debian/
cp -rp ${SCRIPT_DIR}/vesta ${SCRIPT_DIR}/vesta.desktop $BUILD_DIR

apt-get update
apt-get -y upgrade
dpkg-checkbuilddeps 2>&1 | sed 's/dpkg-checkbuilddeps.*dependencies: //' | xargs sudo apt-get -y install
