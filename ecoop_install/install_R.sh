TEMPBUILD=/home/$USER/centos_build
mkdir -p $TEMPBUILD
mkdir -p $TEMPBUILD/tarball
mkdir -p $TEMPBUILD/src

cd $TEMPBUILD 
export PATH=/home/$USER/Envs/env1/bin:$PATH

wget http://cran.us.r-project.org/src/base/R-3/R-3.0.2.tar.gz
tar -zxf R-3.0.2.tar.gz
cd R-3.0.2
CPPFLAGS=-I/home/$USER/Envs/env1/include LDFLAGS=-L/home/$USER/Envs/env1/lib ./configure --prefix=/home/$USER/Envs/env1/ --with-blas --with-lapack >> ../R_configure.log
make -j 8 >> ../R_build.log
make install >> ../R_install.log
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv R-3.0.2.tar.gz $TEMPBUILD/tarball
mv R-3.0.2 $TEMPBUILD/src
ln -s /usr/lib64/gcj-4.4.4/*.so /home/$USER/Envs/env1/lib
mkdir -p /home/$USER/Envs/env1/lib/R/site-library/
/home/$USER/Envs/env1/bin/R CMD javareconf -e
export LD_LIBRARY_PATH=/usr/lib64/gcj-4.4.4/

export PATH=/home/$USER/Envs/env1/bin/

echo "installing rpy2"
/home/$USER/Envs/env1/bin/pip install rpy2  >> pip.log

#R --no-save < cemtos_build/installRpackages.r
#R --no-save < cemtos_build/test.r

# or 
#/home/$USER/Envs/env1/bin/R
#install.packages("ctv")
#library("ctv")
#install.views("Spatial")


