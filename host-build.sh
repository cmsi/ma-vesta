#!/bin/sh
. $(dirname $0)/path.sh

VM="madev9-amd64 madev9-i386 madev8-amd64 madev8-i386 madev7-amd64 madev7-i386"
for v in $VM; do
  cd $HOME/vagrant/$v
  vagrant ssh -c "sh development/ma-${PACKAGE}/setup.sh"
  vagrant ssh -c "sh development/ma-${PACKAGE}/build.sh"
done
