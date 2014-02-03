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
﻿
np=`cat /proc/cpuinfo | grep processor | wc -l`

CURRENTDIR=${PWD}
BUILD=epilib
PREFIX=/home/$USER/Envs/env1

TEMPBUILD=/home/$USER/$BUILD
mkdir -p $TEMPBUILD
mkdir -p $TEMPBUILD/tarball
mkdir -p $TEMPBUILD/src

export PATH=$PREFIX/bin:$PATH
export LD_LIBRARY_PATH=$PREFIX/lib:$PREFIX/lib64:$LD_LIBRARY_PATH

cd $TEMPBUILD
wget http://www.cmake.org/files/v2.8/cmake-2.8.12.2.tar.gz
tar -zxvf cmake-2.8.12.2.tar.gz 
cd cmake-2.8.12.2
./configure --prefix=$PREFIX
gmake
make install
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv cmake-2.8.12.2.tar.gz $TEMPBUILD/tarball
mv cmake-2.8.12.2 $TEMPBUILD/src



cd $PREFIX
wget http://repo.continuum.io/pkgs/free/linux-64/llvm-3.2-0.tar.bz2
tar -xjf llvm-3.2-0.tar.bz2
rm -rf llvm-3.2-0.tar.bz2
PATH+=$PREFIX/bin
export LD_LIBRARY_PATH=$PREFIX/lib:$PREFIX/lib64:$LD_LIBRARY_PATH
export LLVM_CONFIG_PATH=$PREFIX/bin/llvm-config
$LLVM_CONFIG_PATH --cflags # test llvm-config
export LLVMPY_DYNLINK=1
export CFLAGS="-Wno-strict-aliasing -Wno-unused -Wno-write-strings -Wno-unused-function"
git clone https://github.com/hgrecco/llvmpy.git -q
cd llvmpy ; python setup.py install -q >/dev/null ; cd ..
#rm -rf llvmpy
export LD_LIBRARY_PATH=$PREFIX/lib:$PREFIX/lib64:$LD_LIBRARY_PATH
git clone https://github.com/numba/numba.git
cd numba
$PREFIX/bin/pip install -r requirements.txt
$PREFIX/bin/python setup.py install
cd ..
rm -rf numba
rm -rf llvmpy
# or move to src

### start Blaze and few extra pkg

$PREFIX/bin/pip install Blosc

git clone https://github.com/ContinuumIO/blz.git
cd blz
$PREFIX/bin/python setu.py install
cd ..
# rm -rf blz

git clone https://github.com/ContinuumIO/datashape.git
cd datashape
$PREFIX/bin/python setup.py install
cd ..
# rm -rf datashape

git clone https://github.com/ContinuumIO/dynd-python
cd dynd-python
mkdir libraries
cd libraries
git clone https://github.com/ContinuumIO/libdynd
cd ..
mkdir build
cd build
$PREFIX/bin/cmake -DCMAKE_INSTALL_PREFIX=$PREFIX .. #-DCMAKE_BUILD_TYPE=RelWithDebInfo ..
make -j $np
make install
cd ../..

git clone https://github.com/pykit/pykit.git
cd pykit
$PREFIX/bin/python setup.py install
cd ..

git clone https://github.com/ContinuumIO/blaze.git
cd blaze
$PREFIX/bin/python setup.py install
cd ..

$PREFIX/bin/pip install pyyaml
$PREFIX/bin/pip install ply


git clone git://github.com/Theano/Theano.git
cd Theano
$PREFIX/bin/python setup.py install
cd ..

$PREFIX/bin/pip install graphviz

#wget http://www.graphviz.org/pub/graphviz/stable/SOURCES/graphviz-2.36.0.tar.gz
#tar -zxvf graphviz-2.36.0.tar.gz
#cd graphviz-2.36.0
#./configure --prefix=$PREFIX
#make -j $np
#make install

$PREFIX/bin/pip install sh
$PREFIX/bin/pip install flask

