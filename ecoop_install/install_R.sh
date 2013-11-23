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

﻿np=`cat /proc/cpuinfo | grep processor | wc -l`

CURRENTDIR=${PWD}

BUILD=epilib
PREFIX=/home/$USER/Envs/env1

TEMPBUILD=/home/$USER/$BUILD

mkdir -p $TEMPBUILD
mkdir -p $TEMPBUILD/tarball
mkdir -p $TEMPBUILD/src

cd $TEMPBUILD 
export PATH=$PREFIX/bin:$PATH

wget http://cran.us.r-project.org/src/base/R-3/R-3.0.2.tar.gz
tar -zxf R-3.0.2.tar.gz
cd R-3.0.2
CPPFLAGS=-I$PREFIX/include LDFLAGS=-L$PREFIX/lib ./configure --prefix=$PREFIX/ --with-blas --with-lapack --enable-R-shlib >> ../R_configure.log
make -j $np >> ../R_build.log
make install >> ../R_install.log
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv R-3.0.2.tar.gz $TEMPBUILD/tarball
mv R-3.0.2 $TEMPBUILD/src
ln -s /usr/lib64/gcj-4.4.4/*.so $PREFIX/lib
mkdir -p $PREFIX/lib/R/site-library/

cd $CURRENTDIR

export PATH=$PREFIX/bin:$PATH
echo "installing rpy2"
$PREFIX/bin/pip install rpy2  >> pip.log

$PREFIX/bin/R CMD javareconf -e
export LD_LIBRARY_PATH=/usr/lib64/gcj-4.4.4/

#R --no-save < cemtos_build/installRpackages.r
#R --no-save < cemtos_build/test.r

# or 
#$PREFIX/bin/R
#install.packages("ctv")
#library("ctv")
#install.views("Spatial")


