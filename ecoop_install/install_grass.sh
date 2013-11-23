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


np=`cat /proc/cpuinfo | grep processor | wc -l`

BUILD=epilib
PREFIX=/home/$USER/Envs/env1

TEMPBUILD=/home/$USER/$BUILD

mkdir -p $TEMPBUILD
mkdir -p $TEMPBUILD/tarball
mkdir -p $TEMPBUILD/src

cd $TEMPBUILD 
export PATH=$PREFIX/bin:$PATH
echo "installing grass"
svn -q checkout https://svn.osgeo.org/grass/grass/trunk grass7_trunk
cd grass7_trunk 
#LD_LIBRARY_PATH=$PREFIX/lib/ CPPFLAGS=-I$PREFIX/include LDFLAGS=-L$PREFIX/lib ./configure --with-freetype-includes=/usr/include/freetype2/ --with-geos=$PREFIX/bin/geos-config --with-netcdf=$PREFIX/bin/nc-config --with-proj-data=$PREFIX/share/proj/ --with-postgres=yes --with-sqlite --with-pthread --with-readline --with-lapack --with-blas --with-proj-includes=$PREFIX/include --with-proj-data=$PREFIX/share/ --prefix=$PREFIX >> configure.log
export LD_LIBRARY_PATH=$PREFIX/lib/
./configure --with-freetype-includes=/usr/include/freetype2/ --with-geos=$PREFIX/bin/geos-config --with-netcdf=$PREFIX/bin/nc-config --with-proj-share=$PREFIX/share/proj --with-sqlite --with-pthread --with-readline --with-lapack --with-blas --prefix=$PREFIX --with-proj-includes=$PREFIX/include/ --with-proj-libs=$PREFIX/lib >> ../grass_configure.log
# --with-postgres=yes --with-postgres-includes=$PREFIX/include/ --with-postgres-libs=$PREFIX/lib

make -j $np >> ../grass_build.log
make install >> ../grass_install.log 
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv grass7_trunk $TEMPBUILD/src
