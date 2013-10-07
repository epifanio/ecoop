TEMPBUILD=/home/$USER/centos_build
mkdir -p $TEMPBUILD
mkdir -p $TEMPBUILD/tarball
mkdir -p $TEMPBUILD/src

cd $TEMPBUILD 
export PATH=/home/$USER/Envs/env1/bin:$PATH

echo "installing freexl"
wget http://www.gaia-gis.it/gaia-sins/freexl-1.0.0f.tar.gz
tar -zxf freexl-1.0.0f.tar.gz
cd freexl-1.0.0f
./configure --prefix=/home/$USER/Envs/env1/ >> ../freexl_configure.log
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
CPPFLAGS=-I/home/$USER/Envs/env1/include/ LDFLAGS=-L/home/$USER/Envs/env1/lib ./configure --with-geosconfig=/home/$USER/Envs/env1/bin/geos-config --prefix=/home/$USER/Envs/env1/ >> ../libspatialite_configure.log
make -j 8 >> ../libspatialite_build.log
make install >> ../libspatialite_install.log
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv libspatialite-4.1.1.tar.gz $TEMPBUILD/tarball
mv libspatialite-4.1.1 $TEMPBUILD/src


echo "installing postgresql"
wget http://ftp.postgresql.org/pub/source/v9.3.0/postgresql-9.3.0.tar.gz
tar -zxf postgresql-9.3.0.tar.gz
cd postgresql-9.3.0
./configure --prefix=/home/$USER/Envs/env1/ >> ../postgresql_configure.log
make -j 8 >> ../postgresql_build.log
make install >> ../postgresql_install.log
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv postgresql-9.3.0.tar.gz $TEMPBUILD/tarball
mv postgresql-9.3.0 $TEMPBUILD/src

#/home/$USER/Envs/env1/bin/pip install psycopg2 
#python setup.py build_ext --pg-config /path/to/pg_config build ...

echo "installing psycopg2"
wget http://initd.org/psycopg/tarballs/PSYCOPG-2-5/psycopg2-2.5.1.tar.gz
tar -zxf psycopg2-2.5.1.tar.gz
cd psycopg2-2.5.1
/home/$USER/Envs/env1/bin/python setup.py build_ext --pg-config /home/$USER/Envs/env1/bin/pg_config 
/home/$USER/Envs/env1/bin/python setup.py install >> ../pyinstall.log
rm -rf build
cd $TEMPBUILD 
mv psycopg2-2.5.1.tar.gz $TEMPBUILD/tarball
mv psycopg2-2.5.1 $TEMPBUILD/src