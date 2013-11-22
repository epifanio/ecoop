#!/bin/bash -l

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

PREFIX=/home/$USER/Envs/env1

export LD_LIBRARY_PATH=$PREFIX/grass-7.0.svn/lib:$LD_LIBRARY_PATH
export PYTHONPATH=$PREFIX/grass-7.0.svn/etc/python:$PYTHONPATH
export GISBASE=$PREFIX/grass-7.0.svn/
export PATH=$PATH:$GISBASE/bin:$GISBASE/scripts

export GIS_LOCK=$$

mkdir -p /home/$USER/Envs/grass7data
mkdir -p /home/$USER/Envs/.grass7

export GISRC=/home/$USER/Envs/.grass7/rc

export GISDBASE=/home/$USER/Envs/grass7data

export GRASS_TRANSPARENT=TRUE
export GRASS_TRUECOLOR=TRUE
export GRASS_PNG_COMPRESSION=9
export GRASS_PNG_AUTO_WRITE=TRUE

export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe/
export LD_LIBRARY_PATH=/u01/app/oracle/product/11.2.0/xe/lib:$LD_LIBRARY_PATH
export PATH=/u01/app/oracle/product/11.2.0/xe:/home/$USER/Envs/env1/bin:/home/$USER/Envs/env1/cabal/bin:$PATH


# --deep-reload
# --ip=10.240.133.36 --port=8888

ipython notebook --pylab=inline --ipython-dir=$PREFIX/.ipython --profile=default --notebook-dir=/home/$USER/Envs/notebooks/ --no-browser --script