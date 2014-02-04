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

# PYTHON

CURRENTDIR=${PWD}
BUILD=epilib
PREFIX=/home/$USER/Envs/env1

TEMPBUILD=/home/$USER/$BUILD
mkdir -p $TEMPBUILD
mkdir -p $TEMPBUILD/tarball
mkdir -p $TEMPBUILD/src

cd $TEMPBUILD 
export PATH=$PREFIX/bin:$PATH
export LD_LIBRARY_PATH=$PREFIX/lib:$PREFIX/lib64:$LD_LIBRARY_PATH

wget http://python.org/ftp/python/2.7.6/Python-2.7.6.tar.xz
tar xpvf Python-2.7.6.tar.xz
cd Python-2.7.6

export CFLAGS="-fPIC"
./configure --prefix=$PREFIX --enable-shared
make -j $np
make altinstall
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv Python-2.7.6.tar.xz $TEMPBUILD/tarball
mv Python-2.7.6 $TEMPBUILD/src

export PATH=$PREFIX/bin:$PATH

ln -s $PREFIX/bin/python2.7 $PREFIX/bin/python
wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
$PREFIX/bin/python2.7 ez_setup.py
mv ez_setup.py $TEMPBUILD/tarball
mv setuptools-* $TEMPBUILD/src

echo "installing pip"
$PREFIX/bin/easy_install-2.7 pip 
echo "installing virtualenv"
$PREFIX/bin/pip install virtualenv 
echo "installing setuptools"
$PREFIX/bin/pip install setuptools
echo "installing dateutils"
$PREFIX/bin/pip install dateutils
echo "installing docutils"
$PREFIX/bin/pip install docutils
echo "installing jinja2"
$PREFIX/bin/pip install jinja2
echo "installing nose"
$PREFIX/bin/pip install nose
echo "installing numpy"
$PREFIX/bin/pip install numpy
echo "installing paramiko"
$PREFIX/bin/pip install paramiko
echo "installing Image"
$PREFIX/bin/pip install Image
echo "installing pygments"
$PREFIX/bin/pip install pygments
echo "installing scipy"
$PREFIX/bin/pip install scipy
echo "installing sphinx"
$PREFIX/bin/pip install sphinx

echo "installing matplotlib"
git clone https://github.com/matplotlib/matplotlib.git
cd matplotlib
$PREFIX/bin/python setup.py install
cd ..
mv matplotlib $TEMPBUILD/src

#echo "installing matplotlib"
#$PREFIX/bin/pip install matplotlib

echo "installing pyzmq"
$PREFIX/bin/pip install pyzmq
echo "installing tornado"
$PREFIX/bin/pip install tornado
echo "installing envoy"
$PREFIX/bin/pip install envoy
echo "installing qrcode"
$PREFIX/bin/pip install qrcode
echo "installing requests"
$PREFIX/bin/pip install requests
echo "installing owslib"
$PREFIX/bin/pip install owslib

echo "installing husl"
$PREFIX/bin/pip install husl
echo "installing moss"
$PREFIX/bin/pip install moss
echo "installing seaborn"
$PREFIX/bin/pip install seaborn

cd $TEMPBUILD
wget http://www.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.8.12.tar.gz
tar -zxf hdf5-1.8.12.tar.gz
cd hdf5-1.8.12
./configure --prefix=$PREFIX/ --enable-shared --enable-hl
make -j $np
make install
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv hdf5-1.8.12.tar.gz $TEMPBUILD/tarball
mv hdf5-1.8.12 $TEMPBUILD/src
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4.3.0.tar.gz
tar -zxf netcdf-4.3.0.tar.gz
cd netcdf-4.3.0
LDFLAGS=-L$PREFIX/lib CPPFLAGS=-I$PREFIX/include ./configure --enable-netcdf-4 --enable-dap --enable-shared --prefix=$PREFIX
make -j $np
make install
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv netcdf-4.3.0.tar.gz $TEMPBUILD/tarball
mv netcdf-4.3.0 $TEMPBUILD/src


wget ftp://ftp.unidata.ucar.edu/pub/udunits/udunits-2.1.24.tar.gz
tar -zxf udunits-2.1.24.tar.gz
cd udunits-2.1.24
./configure --prefix=$PREFIX
make -j $np
make install
cd $TEMPBUILD
mv udunits-2.1.24.tar.gz $TEMPBUILD/tarball
mv udunits-2.1.24 $TEMPBUILD/src


svn checkout http://netcdf4-python.googlecode.com/svn/trunk/ netcdf4-python
cd netcdf4-python
export HDF5_DIR=$PREFIX/
export NETCDF4_DIR=$PREFIX/
$PREFIX/bin/python setup.py install
rm -rf build
cd $TEMPBUILD
mv netcdf4-python $TEMPBUILD/src


export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe/
export LD_LIBRARY_PATH=/u01/app/oracle/product/11.2.0/xe/lib:$LD_LIBRARY_PATH
wget http://softlayer-dal.dl.sourceforge.net/project/cx-oracle/5.1.2/cx_Oracle-5.1.2.tar.gz
tar -zxf cx_Oracle-5.1.2.tar.gz
cd cx_Oracle-5.1.2
$PREFIX/bin/python setup.py install
rm -rf build
cd $TEMPBUILD
mv cx_Oracle-5.1.2.tar.gz $TEMPBUILD/tarball
mv cx_Oracle-5.1.2 $TEMPBUILD/src



echo "installing h5py"
$PREFIX/bin/pip install h5py
echo "installing numexpr"
$PREFIX/bin/pip install numexpr
echo "installing Cython"
$PREFIX/bin/pip install Cython
echo "installing tables"
$PREFIX/bin/pip install tables
echo "installing pandas"
$PREFIX/bin/pip install pandas
echo "installing patsy"
$PREFIX/bin/pip install patsy
echo "installing pysal"
$PREFIX/bin/pip install pysal
echo "installing statsmodels"
$PREFIX/bin/pip install statsmodels
echo "installing pyke"
$PREFIX/bin/pip install pyke
echo "installing mock"
$PREFIX/bin/pip install mock
echo "installing sqlalchemy"
$PREFIX/bin/pip install sqlalchemy
echo "installing tempdir"
$PREFIX/bin/pip install tempdir
echo "installing pysqlite"
$PREFIX/bin/pip install pysqlite
echo "installing pycsw"
$PREFIX/bin/pip install pycsw
echo "installing sympy"
$PREFIX/bin/pip install sympy



wget --no-check-certificate -c --progress=dot:mega \
  "https://software.ecmwf.int/wiki/download/attachments/3473437/grib_api-1.9.16.tar.gz"
tar xzf grib_api-1.9.16.tar.gz

cd grib_api-1.9.16
export CFLAGS="-O2 -fPIC"
./configure --enable-python --prefix=$PREFIX/
make -j $np
make install
make distclean
cd $TEMPBUILD
mv grib_api-1.9.16.tar.gz $TEMPBUILD/tarball 
mv grib_api-1.9.16 $TEMPBUILD/src

echo "$PREFIX/lib/python2.7/site-packages/grib_api" > gribapi.pth
cp gribapi.pth $PREFIX/lib/python2.7/site-packages/

git clone https://github.com/activepapers/activepapers-python.git
cd activepapers-python
$PREFIX/bin/python setup.py install
rm -rf build
cd $TEMPBUILD
mv activepapers-python $TEMPBUILD/src

echo "installing scikit-learn"
$PREFIX/bin/pip install scikit-learn

echo "installing scikit-image"
$PREFIX/bin/pip install scikit-image

echo "installing sympy"
$PREFIX/bin/pip install sympy

echo "install mpld3"
git clone https://github.com/jakevdp/mpld3.git
cd mpld3
$PREFIX/bin/python setup.py install
rm -rf build
cd $TEMPBUILD
mv mpld3 $TEMPBUILD/src

#https://github.com/jakevdp/ipywidgets.git
git clone https://github.com/jakevdp/ipywidgets.git
cd ipywidgets
$PREFIX/bin/python setup.py install
rm -rf build
cd $TEMPBUILD
mv ipywidgets $TEMPBUILD/src



git clone https://github.com/epmoyer/ipy_table.git
cd ipy_table
$PREFIX/bin/python setup.py install
rm -rf build
cd $TEMPBUILD
mv ipy_table $TEMPBUILD/src

# think about ipython extension / profiles (grass binding, network interfaces)
#

git clone https://github.com/ContinuumIO/bokeh.git
cd bokeh
$PREFIX/bin/python setup.py install
cd ..
mv bokeh $TEMPBUILD/src

git clone https://github.com/ipython/ipython
cd ipython
$PREFIX/bin/python setup.py install
rm -rf build
cd $TEMPBUILD
mv ipython $TEMPBUILD/src

ipython profile create default
ipython profile create ecoop --ipython-dir=$PREFIX/.ipython --parallel

mkdir -p /home/$USER/Envs/notebooks/
cp $CURRENTDIR/ipython.sh $PREFIX/bin



