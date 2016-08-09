#!/bin/sh

URL=http://www.geocities.jp/kmo_mma/crystal/download/VESTA-x86_64.tar.bz2

rm -rf VESTA-x86_64 ../dist
wget -O - $URL | tar jxf -
mv VESTA-x86_64 ../dist
