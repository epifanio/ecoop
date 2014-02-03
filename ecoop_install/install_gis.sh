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

BUILD=epilib
PREFIX=/home/$USER/Envs/env1

TEMPBUILD=/home/$USER/$BUILD

mkdir -p $TEMPBUILD
mkdir -p $TEMPBUILD/tarball
mkdir -p $TEMPBUILD/src

cd $TEMPBUILD 
export PATH=$PREFIX/bin:$PATH
export LD_LIBRARY_PATH=$PREFIX/lib:$PREFIX/lib64:$LD_LIBRARY_PATH


echo "installing proj"
wget http://download.osgeo.org/proj/proj-4.8.0.tar.gz
tar -zxf proj-4.8.0.tar.gz 
cd proj-4.8.0
./configure --prefix=$PREFIX/ >> ../proj_configure.log
make -j $np >> ../proj_build.log
make install >> ../proj_install.log
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv proj-4.8.0.tar.gz $TEMPBUILD/tarball
mv proj-4.8.0 $TEMPBUILD/src

echo "installing geos & basemap"
wget http://softlayer-dal.dl.sourceforge.net/project/matplotlib/matplotlib-toolkits/basemap-1.0.7/basemap-1.0.7.tar.gz
tar -zxf basemap-1.0.7.tar.gz
cd basemap-1.0.7
cd geos-3.3.3
export GEOS_DIR=$PREFIX/
./configure --prefix=$GEOS_DIR >> ../../geos_configure.log
make -j $np >> ../../geos_build.log
make install >> ../../geos_install.log
make distclean > /dev/null 2>&1
cd ..
$PREFIX/bin/python setup.py install >> ../pyinstall.log
rm -rf build
cd $TEMPBUILD
mv basemap-1.0.7.tar.gz $TEMPBUILD/tarball
mv basemap-1.0.7 $TEMPBUILD/src


echo "installing shapely"
$PREFIX/bin/pip install shapely >> pip.log
echo "installing descartes"
$PREFIX/bin/pip install descartes >> pip.log

echo "installing shapelib"
wget http://download.osgeo.org/shapelib/shapelib-1.3.0.tar.gz
tar -zxf shapelib-1.3.0.tar.gz
cd shapelib-1.3.0
wget http://ftp.intevation.de/users/bh/pyshapelib/pyshapelib-0.3.tar.gz
tar -zxf pyshapelib-0.3.tar.gz
cd pyshapelib-0.3
$PREFIX/bin/python setup.py install >> pyinstall.log
rm -rf build
cd $TEMPBUILD 
mv shapelib-1.3.0.tar.gz $TEMPBUILD/tarball
mv shapelib-1.3.0 $TEMPBUILD/src


echo "installing pyproj"
$PREFIX/bin/pip install pyproj >> pip.log

echo "installing pyproj"
git clone https://github.com/SciTools/cartopy.git
cd cartopy
$PREFIX/bin/python setup.py install >> pyinstall.log
rm -rf build
cd $TEMPBUILD 



