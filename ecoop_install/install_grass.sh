BUILD=epilib
PREFIX=/home/$USER/Envs/env1

TEMPBUILD=/home/$USER/$BUILD

mkdir -p $TEMPBUILD
mkdir -p $TEMPBUILD/tarball
mkdir -p $TEMPBUILD/src

cd $TEMPBUILD 
export PATH=$PREFIX/bin:$PATH
echo "installing grass"
svn -q checkout https://svn.osgeo.org/grass/grass/trunk grass7_trunk
cd grass7_trunk 
#LD_LIBRARY_PATH=$PREFIX/lib/ CPPFLAGS=-I$PREFIX/include LDFLAGS=-L$PREFIX/lib ./configure --with-freetype-includes=/usr/include/freetype2/ --with-geos=$PREFIX/bin/geos-config --with-netcdf=$PREFIX/bin/nc-config --with-proj-data=$PREFIX/share/proj/ --with-postgres=yes --with-sqlite --with-pthread --with-readline --with-lapack --with-blas --with-proj-includes=$PREFIX/include --with-proj-data=$PREFIX/share/ --prefix=$PREFIX >> configure.log
export LD_LIBRARY_PATH=$PREFIX/lib/
./configure --with-freetype-includes=/usr/include/freetype2/ --with-geos=$PREFIX/bin/geos-config --with-netcdf=$PREFIX/bin/nc-config --with-proj-share=$PREFIX/share/proj --with-postgres=yes --with-sqlite --with-pthread --with-readline --with-lapack --with-blas --prefix=$PREFIX --with-proj-includes=$PREFIX/include/ --with-proj-libs=$PREFIX/lib --with-postgres-includes=$PREFIX/include/ --with-postgres-libs=$PREFIX/lib  >> ../grass_configure.log


make -j 8 >> ../grass_build.log
make install >> ../grass_install.log 
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv grass7_trunk $TEMPBUILD/src
