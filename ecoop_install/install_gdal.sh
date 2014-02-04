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


wget http://download.osgeo.org/gdal/1.10.1/gdal-1.10.1.tar.gz
tar -zxf gdal-1.10.1.tar.gz
cd gdal-1.10.1
#--with-pg=$PREFIX/bin/pg_config
CPPFLAGS=-I$PREFIX/include ./configure --with-hdf5=$PREFIX/  --with-geos=$PREFIX/bin/geos-config --with-spatialite=$PREFIX/ --with-freexl=$PREFIX/ --with-python=$PREFIX/bin/python --with-pg=$PREFIX/bin/pg_config --prefix=$PREFIX/ --with-netcdf=$PREFIX/ >> ../gdal_configure.log
make -j $np
make install
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv gdal-1.10.1.tar.gz $TEMPBUILD/tarball
mv gdal-1.10.1 $TEMPBUILD/src
$PREFIX/bin/pip install fiona


$PREFIX/bin/pip install Image

wget http://hivelocity.dl.sourceforge.net/project/pyke/pyke/1.1.1/pyke-1.1.1.zip
unzip pyke-1.1.1.zip
cd pyke-1.1.1
$PREFIX/bin/python setup.py install
rm -rf build
cd $TEMPBUILD
mv pyke-1.1.1 $TEMPBUILD/src

$PREFIX/bin/pip install biggus

#git clone https://github.com/SciTools/iris.git
#cd iris
#$PREFIX/bin/python setup.py install
#cd ..
#mv iris $TEMPBUILD/src

