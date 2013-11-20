BUILD=epilib
PREFIX=/home/$USER/Envs/env1

TEMPBUILD=/home/$USER/$BUILD
mkdir -p $TEMPBUILD
mkdir -p $TEMPBUILD/tarball
mkdir -p $TEMPBUILD/src

cd $TEMPBUILD 
export PATH=$PREFIX/bin:$PATH

wget http://download.osgeo.org/gdal/1.10.1/gdal-1.10.1.tar.gz
tar -zxf gdal-1.10.1.tar.gz
cd gdal-1.10.1
#--with-pg=$PREFIX/bin/pg_config
CPPFLAGS=-I$PREFIX/include ./configure --with-hdf5=$PREFIX/  --with-geos=$PREFIX/bin/geos-config --with-spatialite=$PREFIX/ --with-freexl=$PREFIX/ --with-python=$PREFIX/bin/python --prefix=$PREFIX/ --with-netcdf=$PREFIX/ >> ../gdal_configure.log
make -j 8 >> ../gdal_build.log
make install >> ../gdal_install.log
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv gdal-1.10.1.tar.gz $TEMPBUILD/tarball
mv gdal-1.10.1 $TEMPBUILD/src
$PREFIX/bin/pip install fiona >> pip.log
