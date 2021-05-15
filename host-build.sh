#!/bin/sh
. $(dirname $0)/path.sh

VM="$*"
test -z "$VM" && VM="madev10-amd64 ubuntu20-amd64 ubuntu18-amd64"
for v in $VM; do
  cd $HOME/vagrant/$v
  vagrant ssh -c "sh malive/development/ma-${PACKAGE}/setup.sh"
  vagrant ssh -c "sh malive/development/ma-${PACKAGE}/build.sh"
done
