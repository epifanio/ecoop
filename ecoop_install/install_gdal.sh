TEMPBUILD=/home/$USER/centos_build
mkdir -p $TEMPBUILD
mkdir -p $TEMPBUILD/tarball
mkdir -p $TEMPBUILD/src

cd $TEMPBUILD 
export PATH=/home/$USER/Envs/env1/bin:$PATH

wget http://download.osgeo.org/gdal/1.10.1/gdal-1.10.1.tar.gz
tar -zxf gdal-1.10.1.tar.gz
cd gdal-1.10.1
CPPFLAGS=-I/home/$USER/Envs/env1/include ./configure --with-hdf5=/home/$USER/Envs/env1/ --with-pg=/home/$USER/Envs/env1/bin/pg_config --with-geos=/home/$USER/Envs/env1/bin/geos-config --with-spatialite=/home/$USER/Envs/env1/ --with-freexl=/home/$USER/Envs/env1/ --with-python=/home/$USER/Envs/env1/bin/python --prefix=/home/$USER/Envs/env1/ --with-netcf=/home/$USER/Envs/env1/ >> ../gdal_configure.log
make -j 8 >> ../gdal_build.log
make install >> ../gdal_install.log
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv gdal-1.10.1.tar.gz $TEMPBUILD/tarball
mv gdal-1.10.1 $TEMPBUILD/src
/home/$USER/Envs/env1/bin/pip install fiona >> pip.log
