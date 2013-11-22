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

CURRENTDIR=${PWD}
BUILD=epilib
PREFIX=/home/$USER/Envs/env1

TEMPBUILD=/home/$USER/$BUILD
mkdir -p $TEMPBUILD
mkdir -p $TEMPBUILD/tarball
mkdir -p $TEMPBUILD/src

cd $TEMPBUILD
export PATH=$PREFIX/bin:$PATH

wget http://www.haskell.org/ghc/dist/7.6.3/ghc-7.6.3-x86_64-unknown-linux.tar.bz2
bunzip2 ghc-7.6.3-x86_64-unknown-linux.tar.bz2
tar -xvf ghc-7.6.3-x86_64-unknown-linux.tar
cd ghc-7.6.3
./configure --prefix=$PREFIX >> ../ghc_configure.log
make install >> ../ghc_install.log

make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv ghc-7.6.3-x86_64-unknown-linux.tar.bz2 $TEMPBUILD/tarball
rm -rf ghc-7.6.3-x86_64-unknown-linux.tar
mv ghc-7.6.3 $TEMPBUILD/src

cd $TEMPBUILD


wget http://www.haskell.org/cabal/release/cabal-1.18.1.2/Cabal-1.18.1.2.tar.gz
tar -zxvf Cabal-1.18.1.2.tar.gz
cd Cabal-1.18.1.2
ghc --make Setup
./Setup configure --user --prefix=$PREFIX
./Setup build
./Setup install

cd ..
wget http://www.haskell.org/cabal/release/cabal-install-1.18.0.2/cabal-install-1.18.0.2.tar.gz
tar -zxvf cabal-install-1.18.0.2.tar.gz
cd cabal-install-1.18.0.2
./bootstrap.sh
#ln -s /home/$USER/.cabal/bin/cabal $PREFIX/bin/
export PATH=/home/$USER/.cabal/bin/cabal/bin:$PATH
cabal update
cabal install alex
cabal install happy
cabal install pandoc
cp -R /home/ecoop/.cabal/ /home/ecoop/Envs/env1/cabal
