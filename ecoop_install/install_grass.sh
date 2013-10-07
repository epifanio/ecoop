TEMPBUILD=/home/$USER/centos_build
mkdir -p $TEMPBUILD
mkdir -p $TEMPBUILD/tarball
mkdir -p $TEMPBUILD/src

cd $TEMPBUILD 
export PATH=/home/$USER/Envs/env1/bin:$PATH

svn checkout https://svn.osgeo.org/grass/grass/trunk grass7_trunk
cd grass7_trunk
#LD_LIBRARY_PATH=/home/$USER/Envs/env1/lib/ CPPFLAGS=-I/home/$USER/Envs/env1/include LDFLAGS=-L/home/$USER/Envs/env1/lib ./configure --with-freetype-includes=/usr/include/freetype2/ --with-geos=/home/$USER/Envs/env1/bin/geos-config --with-netcdf=/home/$USER/Envs/env1/bin/nc-config --with-proj-data=/home/$USER/Envs/env1/share/proj/ --with-postgres=yes --with-sqlite --with-pthread --with-readline --with-lapack --with-blas --with-proj-includes=/home/$USER/Envs/env1/include --with-proj-data=/home/$USER/Envs/env1/share/ --prefix=/home/$USER/Envs/env1 >> configure.log
export LD_LIBRARY_PATH=/home/$USER/Envs/env1/lib/
./configure --with-freetype-includes=/usr/include/freetype2/ --with-geos=/home/$USER/Envs/env1/bin/geos-config --with-netcdf=/home/$USER/Envs/env1/bin/nc-config --with-proj-data=/home/$USER/Envs/env1/share/proj/ --with-postgres=yes --with-sqlite --with-pthread --with-readline --with-lapack --with-blas --prefix=/home/$USER/Envs/env1 --with-proj-includes=/home/$USER/Envs/env1/include/ --with-proj-libs=/home/$USER/Envs/env1/lib --with-postgres-includes=/home/$USER/Envs/env1/include/ --with-postgres-libs=/home/$USER/Envs/env1/lib  >> ../grass_configure.log


make -j 8 >> ../grass_build.log
make install >> ../grass_install.log 
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv grass7_trunk $TEMPBUILD/src
