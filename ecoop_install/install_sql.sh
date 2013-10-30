BUILD=epilib
PREFIX=/home/$USER/Envs/env1

TEMPBUILD=/home/$USER/$BUILD

mkdir -p $TEMPBUILD
mkdir -p $TEMPBUILD/tarball
mkdir -p $TEMPBUILD/src

cd $TEMPBUILD 
export PATH=$PREFIX/bin:$PATH

echo "installing freexl"
wget http://www.gaia-gis.it/gaia-sins/freexl-1.0.0f.tar.gz
tar -zxf freexl-1.0.0f.tar.gz
cd freexl-1.0.0f
./configure --prefix=$PREFIX/ >> ../freexl_configure.log
make -j 8 >> ../freexl_build.log
make install >> ../freexl_install.log
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv freexl-1.0.0f.tar.gz $TEMPBUILD/tarball
mv freexl-1.0.0f $TEMPBUILD/src


echo "installing libspatialite"
wget http://www.gaia-gis.it/gaia-sins/libspatialite-sources/libspatialite-4.1.1.tar.gz
tar -zxf libspatialite-4.1.1.tar.gz
cd libspatialite-4.1.1
CPPFLAGS=-I$PREFIX/include/ LDFLAGS=-L$PREFIX/lib ./configure --with-geosconfig=$PREFIX/bin/geos-config --prefix=$PREFIX/ >> ../libspatialite_configure.log
make -j 8 >> ../libspatialite_build.log
make install >> ../libspatialite_install.log
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv libspatialite-4.1.1.tar.gz $TEMPBUILD/tarball
mv libspatialite-4.1.1 $TEMPBUILD/src


#echo "installing postgresql"
#wget http://ftp.postgresql.org/pub/source/v9.3.0/postgresql-9.3.0.tar.gz
#tar -zxf postgresql-9.3.0.tar.gz
#cd postgresql-9.3.0
#./configure --prefix=$PREFIX/ >> ../postgresql_configure.log
#make -j 8 >> ../postgresql_build.log
#make install >> ../postgresql_install.log
#make distclean > /dev/null 2>&1
#cd $TEMPBUILD
#mv postgresql-9.3.0.tar.gz $TEMPBUILD/tarball
#mv postgresql-9.3.0 $TEMPBUILD/src

#$PREFIX/bin/pip install psycopg2 
#python setup.py build_ext --pg-config /path/to/pg_config build ...

#echo "installing psycopg2"
#wget http://initd.org/psycopg/tarballs/PSYCOPG-2-5/psycopg2-2.5.1.tar.gz
#tar -zxf psycopg2-2.5.1.tar.gz
#cd psycopg2-2.5.1
#$PREFIX/bin/python setup.py build_ext --pg-config $PREFIX/bin/pg_config 
#$PREFIX/bin/python setup.py install >> ../pyinstall.log
#rm -rf build
#cd $TEMPBUILD 
#mv psycopg2-2.5.1.tar.gz $TEMPBUILD/tarball
#mv psycopg2-2.5.1 $TEMPBUILD/src
