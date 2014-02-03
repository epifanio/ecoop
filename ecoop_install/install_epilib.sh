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

wget http://orion.tw.rpi.edu/~epifanio/epinux-0-1.tar.gz
mkdir Envs
cd Envs
tar -zxvf ../epinux-0-1.tar.gz .
cd ..
cp -R Envs $1/

echo 'export PATH=''"'"$1"'/Envs/env1/bin:'"$1"'/Envs/env1/cabal/bin:$PATH''"' >> $HOME/.bashrc
echo 'export LD_LIBRARY_PATH=''"'"$1"'/Envs/env1/lib/:$LD_LIBRARY_PATH''"' >> $HOME/.bashrc
echo "@reboot sh $1/Envs/env1/bin/ipython.sh &" >> crontab.txt
crontab crontab.txt
rm -rf crontab.txt
rm -rf $1/Envs/env1/bin/python
ln -s $1/Envs/env1/bin/python2.7 $1/Envs/env1/bin/python   
for f in $1/Envs/env1/bin/{theano-test,theano-nose,theano-cache,rdfs2dot,rdfpipe,rdfgraphisomorphism,rdf2dot,csv2rdf,depyc,numba,2to3,idle,nc-config,rst2html.py,cygdb,ipcluster,ncinfo,rst2latex.py,cython,ipcluster2,nosetests,rst2man.py,dateadd,ipcontroller,nosetests-2.7,rst2odt_prepstyles.py,datediff,ipcontroller2,octave-config-3.6.4,rst2odt.py,dumpgj,ipengine,pilconvert.py,rst2pseudoxml.py,easy_install,ipengine2,pildriver.py,rst2s5.py,easy_install-2.7,iplogger,pilfile.py,rst2xetex.py,f2py2.7,iplogger2,pilprint.py,rst2xml.py,gdal-config,iptest,pip,rstpep2html.py,geos-config,iptest2,pip-2.7,runghc-7.6.3,ghc-7.6.3,ipython,pt2to3,ghci-7.6.3,ipython2,ipython.sh,ptdump,smtpd.py,ghc-pkg-7.6.3,ipython.sh,ptrepack,sphinx-apidoc,grass70,irunner,pydoc,sphinx-autogen,grib1to2,irunner2,pygmentize,sphinx-build,h5cc,mkoctfile-3.6.4,python2.7-config,sphinx-quickstart,haddock-ghc-7.6.3,nc3tonc4,qr,virtualenv,hsc2hs,nc4tonc3,R,virtualenv-2.7,check_mni_reg,recon_movie,recon_process_stats,recon_status,ts_movie}; do printf '%s\n' ",s,/home/ecoop,$1,g" w | ed -s "$f"; done
for f in $1/Envs/env1/cabal/{config,}; do printf '%s\n' ",s,/home/ecoop/.cabal,$1/env1/cabal/,g" w | ed -s "$f"; done
echo "DONE"
echo "You can remove epinux-0-1.tar.gz"
