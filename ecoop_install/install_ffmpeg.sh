#!/bin/bash

###############################################################################
#
#
# Project: ECOOP, sponsored by The National Science Foundation
# Purpose: this code is part of the Cyberinfrastructure developed for the ECOOP project
#                http://tw.rpi.edu/web/project/ECOOP
#                from the TWC - Tetherless World Constellation
#                            at RPI - Rensselaer Polytechnic Institute
#                            founded by NSF
#
# Author:   Massimo Di Stefano , distem@rpi.edu -
#                http://tw.rpi.edu/web/person/MassimoDiStefano
#
###############################################################################
# Copyright (c) 2008-2014 Tetherless World Constellation at Rensselaer Polytechnic Institute
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
###############################################################################

np=${nproc}

BUILD=epilib
PREFIX=/home/$USER/Envs/env1

TEMPBUILD=/home/$USER/$BUILD

mkdir -p $TEMPBUILD
mkdir -p $TEMPBUILD/tarball
mkdir -p $TEMPBUILD/src

cd $TEMPBUILD
export PATH=$PREFIX/bin:$PATH
export LD_LIBRARY_PATH=$PREFIX/lib:$PREFIX/lib64:$LD_LIBRARY_PATH


wget http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz 
tar xvfz yasm-1.2.0.tar.gz 
cd yasm-1.2.0 
./configure --prefix=$PREFIX 
make -j $np
make install
cd $TEMPBUILD

git clone --depth 1 git://git.videolan.org/x264.git
cd x264
./configure --prefix=$PREFIX --enable-static
make -j $np
make install
make distclean


cd $TEMPBUILD
git clone --depth 1 git://git.code.sf.net/p/opencore-amr/fdk-aac
cd fdk-aac
autoreconf -fiv
./configure --prefix=$PREFIX --disable-shared
make -j $np
make install
make distclean

cd $TEMPBUILD
wget http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz
tar xzvf lame-3.99.5.tar.gz
cd lame-3.99.5
./configure --prefix=$PREFIX --enable-nasm --disable-shared
make -j $np
make install
make distclean


cd $TEMPBUILD
wget http://downloads.xiph.org/releases/opus/opus-1.0.3.tar.gz
tar xzvf opus-1.0.3.tar.gz
cd opus-1.0.3
./configure --prefix=$PREFIX --disable-shared
make -j $np
make install
make distclean

cd $TEMPBUILD
git clone --depth 1 http://git.chromium.org/webm/libvpx.git
cd libvpx
./configure --prefix=$PREFIX --disable-examples
make -j $np
make install
make clean

cd $TEMPBUILD
git clone --depth 1 git://source.ffmpeg.org/ffmpeg
cd ffmpeg
PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig
export PKG_CONFIG_PATH
./configure --prefix=$PREFIX \
  --extra-cflags="-I$PREFIX/include" --extra-ldflags="-L$PREFIX/lib" \
  --extra-libs="-ldl" --enable-gpl --enable-libass --enable-libfdk-aac \
  --enable-libmp3lame --enable-libopus --enable-libtheora --enable-libvorbis --enable-libvpx \
  --enable-libx264 --enable-nonfree --enable-x11grab
make -j $np
make install
make distclean
hash -r
