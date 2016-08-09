#!/bin/sh

URL=http://www.geocities.jp/kmo_mma/crystal/download/VESTA-i686.tar.bz2

rm -rf VESTA-i686 ../dist
wget -O - $URL | tar jxf -
mv VESTA-i686 ../dist
