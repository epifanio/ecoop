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


echo "installing freexl"
wget http://www.gaia-gis.it/gaia-sins/freexl-sources/freexl-1.0.0g.tar.gz
tar -zxf freexl-1.0.0g.tar.gz
cd freexl-1.0.0g
./configure --prefix=$PREFIX/ >> ../freexl_configure.log
make -j $np >> ../freexl_build.log
make install >> ../freexl_install.log
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv freexl-1.0.0g.tar.gz $TEMPBUILD/tarball
mv freexl-1.0.0g $TEMPBUILD/src


echo "installing libspatialite"
wget http://www.gaia-gis.it/gaia-sins/libspatialite-sources/libspatialite-4.1.1.tar.gz
tar -zxf libspatialite-4.1.1.tar.gz
cd libspatialite-4.1.1
CPPFLAGS=-I$PREFIX/include/ LDFLAGS=-L$PREFIX/lib ./configure --with-geosconfig=$PREFIX/bin/geos-config --prefix=$PREFIX/ >> ../libspatialite_configure.log
make -j $np >> ../libspatialite_build.log
make install >> ../libspatialite_install.log
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv libspatialite-4.1.1.tar.gz $TEMPBUILD/tarball
mv libspatialite-4.1.1 $TEMPBUILD/src


echo "installing postgresql"
wget http://ftp.postgresql.org/pub/source/v9.3.0/postgresql-9.3.0.tar.gz
tar -zxf postgresql-9.3.0.tar.gz
cd postgresql-9.3.0
./configure --prefix=$PREFIX/ >> ../postgresql_configure.log
make -j $np >> ../postgresql_build.log
make install >> ../postgresql_install.log
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv postgresql-9.3.0.tar.gz $TEMPBUILD/tarball
mv postgresql-9.3.0 $TEMPBUILD/src

$PREFIX/bin/pip install psycopg2 
python setup.py build_ext --pg-config /path/to/pg_config build ...

echo "installing psycopg2"
wget http://initd.org/psycopg/tarballs/PSYCOPG-2-5/psycopg2-2.5.1.tar.gz
tar -zxf psycopg2-2.5.1.tar.gz
cd psycopg2-2.5.1
$PREFIX/bin/python setup.py build_ext --pg-config $PREFIX/bin/pg_config 
$PREFIX/bin/python setup.py install >> ../pyinstall.log
rm -rf build
cd $TEMPBUILD 
mv psycopg2-2.5.1.tar.gz $TEMPBUILD/tarball
mv psycopg2-2.5.1 $TEMPBUILD/src

