#!/bin/bash

NUM_CORE=$(grep processor /proc/cpuinfo | awk '{field=$NF};END{print field+1}')
WORKING_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)"

ALSA_VERSION_MAJOR=1
ALSA_VERSION_MINOR=2
ALSA_VERSION_PATCH1=7
ALSA_VERSION_PATCH2=2
ALSA="alsa-lib-\
$ALSA_VERSION_MAJOR"."\
$ALSA_VERSION_MINOR"."\
$ALSA_VERSION_PATCH1"."\
$ALSA_VERSION_PATCH2"
ALSA_FILENAME=$WORKING_DIR/$ALSA.tar.bz2
ALSA_FOLDER=$WORKING_DIR/$ALSA
ALSA_URL="https://www.alsa-project.org/files/pub/lib/$ALSA.tar.bz2"

if [ ! -f "$ALSA_FILENAME" ]; then
  wget -q $ALSA_URL -O $ALSA_FILENAME
fi

if [ ! -d $ALSA_FOLDER ]; then
  tar xf $ALSA_FILENAME
fi

cd $ALSA_FOLDER
./configure \
  --enable-shared=no \
  --enable-static=yes \
  --with-pic \
  --host=aarch64-linux-gnu \
  --prefix=/home/munseongjeong/git/alsa-cpp/
make clean
make -j$NUM_CORE
make install
