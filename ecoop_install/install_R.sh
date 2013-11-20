
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
make -j 8 >> ../R_build.log
make install >> ../R_install.log
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv R-3.0.2.tar.gz $TEMPBUILD/tarball
mv R-3.0.2 $TEMPBUILD/src
ln -s /usr/lib64/gcj-4.4.4/*.so $PREFIX/lib
mkdir -p $PREFIX/lib/R/site-library/

cd $CURRENTDIR

export PATH=$PREFIX/bin/
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


