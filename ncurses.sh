#!/bin/bash

NUM_CORE=$(grep processor /proc/cpuinfo | awk '{field=$NF};END{print field+1}')
WORKING_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)"

# TODO: if the directory exists:
git clone https://github.com/mirror/ncurses.git
cp $WORKING_DIR/configure $WORKING_DIR/ncurses
cd ncurses

# TODO: if the directory exists:
BUILD_DIR=$WORKING_DIR/ncurses/build/ncurses
mkdir -p $BUILD_DIR
export CC=aarch64-linux-gnu-gcc
export STRIP=aarch64-linux-gnu-strip
export TIC_PATH=$BUILD_DIR/bin/tic
./configure -host=aarch64-linux-gnu -prefix=$BUILD_DIR
make -j$NUM_CORE
# make install --strip-program=aarch64-linux-gnu-strip
make install

