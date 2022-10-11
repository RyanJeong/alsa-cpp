#!/bin/sh
DIR=`dirname $0`
rm -rf \
  $DIR/bin \
  $DIR/include \
  $DIR/lib \
  $DIR/share \
  $DIR/alsa-lib \
  $DIR/*tar.bz2
