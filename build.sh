#!/bin/bash

NUM_CORE=$(grep processor /proc/cpuinfo | awk '{field=$NF};END{print field+1}')
WORKING_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)"

# alsa-lib
ALSA_LIB_VERSION_MAJOR=1
ALSA_LIB_VERSION_MINOR=2
ALSA_LIB_VERSION_PATCH1=7
ALSA_LIB_VERSION_PATCH2=2
ALSA_LIB="alsa-lib-\
$ALSA_LIB_VERSION_MAJOR"."\
$ALSA_LIB_VERSION_MINOR"."\
$ALSA_LIB_VERSION_PATCH1"."\
$ALSA_LIB_VERSION_PATCH2"
ALSA_LIB_FILENAME=$WORKING_DIR/$ALSA_LIB.tar.bz2
ALSA_LIB_FOLDER=$WORKING_DIR/"alsa-lib"
ALSA_LIB_URL="https://www.alsa-project.org/files/pub/lib/$ALSA_LIB.tar.bz2"

if [ ! -f "$ALSA_LIB_FILENAME" ]; then
  wget -q $ALSA_LIB_URL -O $ALSA_LIB_FILENAME
fi

if [ ! -d $ALSA_LIB_FOLDER ]; then
  mkdir -p $ALSA_LIB_FOLDER
  tar xf $ALSA_LIB_FILENAME -C $ALSA_LIB_FOLDER --strip-components 1
fi

cd $ALSA_LIB_FOLDER
./configure \
  --enable-shared=no \
  --enable-static=yes \
  --with-pic \
  --host=aarch64-linux-gnu \
  --prefix=$WORKING_DIR
make clean
make -j$NUM_CORE
make install

