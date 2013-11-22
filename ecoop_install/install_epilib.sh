wget http://geofemengineering.it/epinux.tar.gz
mkdir Envs
cd Envs
tar -zxvf ../epinux.tar.gz .
cd ..
cp -R Envs $1/

echo 'export PATH=''"'"$1"'/Envs/env1/bin:'"$1"'/Envs/env1/cabal/bin:$PATH''"' >> $HOME/.bashrc
echo 'export LD_LIBRARY_PATH=''"'"$1"'/Envs/env1/lib/:$LD_LIBRARY_PATH''"' >> $HOME/.bashrc
echo "@reboot sh $1/Envs/env1/bin/ipython.sh &" >> crontab.txt
crontab crontab.txt
rm -rf crontab.txt
rm -rf $1/Envs/env1/bin/python
ln -s $1/Envs/env1/bin/python2.7 $1/Envs/env1/bin/python   
for f in $1/Envs/env1/bin/{2to3,idle,nc-config,rst2html.py,cygdb,ipcluster,ncinfo,rst2latex.py,cython,ipcluster2,nosetests,rst2man.py,dateadd,ipcontroller,nosetests-2.7,rst2odt_prepstyles.py,datediff,ipcontroller2,octave-config-3.6.4,rst2odt.py,dumpgj,ipengine,pilconvert.py,rst2pseudoxml.py,easy_install,ipengine2,pildriver.py,rst2s5.py,easy_install-2.7,iplogger,pilfile.py,rst2xetex.py,f2py2.7,iplogger2,pilprint.py,rst2xml.py,gdal-config,iptest,pip,rstpep2html.py,geos-config,iptest2,pip-2.7,runghc-7.6.3,ghc-7.6.3,ipython,pt2to3,ghci-7.6.3,ipython2,ipython.sh,ptdump,smtpd.py,ghc-pkg-7.6.3,ipython.sh,ptrepack,sphinx-apidoc,grass70,irunner,pydoc,sphinx-autogen,grib1to2,irunner2,pygmentize,sphinx-build,h5cc,mkoctfile-3.6.4,python2.7-config,sphinx-quickstart,haddock-ghc-7.6.3,nc3tonc4,qr,virtualenv,hsc2hs,nc4tonc3,R,virtualenv-2.7,check_mni_reg,recon_movie,recon_process_stats,recon_status,ts_movie}; do printf '%s\n' ",s,/home/ecoop,$1,g" w | ed -s "$f"; done
for f in $1/Envs/env1/cabal/{config,}; do printf '%s\n' ",s,/home/ecoop/.cabal,$1/env1/cabal/,g" w | ed -s "$f"; done
echo "DONE"
