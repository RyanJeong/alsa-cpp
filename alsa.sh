#!/bin/bash
# wget https://www.alsa-project.org/files/pub/lib/alsa-lib-1.0.26.tar.bz2
# tar xvf alsa-lib-1.0.26.tar.bz2
# rm alsa-lib-1.0.26.tar.bz
# 
# cd alsa-lib-1.0.26

wget https://www.alsa-project.org/files/pub/lib/alsa-lib-1.2.7.2.tar.bz2
tar xf alsa-lib-1.2.7.2.tar.bz2
rm alsa-lib-1.2.7.2.tar.bz2
cd alsa-lib-1.2.7.2

./configure \
  --enable-shared=no \
  --enable-static=yes \
  --with-pic \
  --host=aarch64-linux-gnu \
  --prefix=/home/munseongjeong/git/alsa-cpp/
make -j8
make install


