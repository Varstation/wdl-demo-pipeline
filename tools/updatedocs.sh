#!/usr/bin/env bash

set -eu


GIT_ROOT="$(git rev-parse --show-toplevel)"
VER_NEW="$1"

cd $GIT_ROOT


mkdir -p  docs/src/$VER_NEW
cp -r docs/src/develop/* docs/src/$VER_NEW/
sed -i.bak "s/latest: .*/latest: ${VER_NEW}/" docs/src/_config.yml && rm docs/src/_config.yml.bak
grep 'latest:' <  docs/src/_config.yml