BUILD=epilib
PREFIX=/home/$USER/Envs/env1

TEMPBUILD=/home/$USER/$BUILD


mkdir -p $TEMPBUILD
mkdir -p $TEMPBUILD/tarball
mkdir -p $TEMPBUILD/src

cd $TEMPBUILD 
export PATH=$PREFIX/bin:$PATH

echo "installing postgis"
wget http://download.osgeo.org/postgis/source/postgis-2.1.0.tar.gz
tar -zxf postgis-2.1.0.tar.gz
cd postgis-2.1.0
./configure --prefix=$PREFIX/ --with-projdir=$PREFIX/ --with-gdalconfig=$PREFIX/bin/gdal-config --with-projdir=$PREFIX/ >> ../postgis_configure.log
make -j 8 >> ../postgis_build.log
make install >> ../postgis_install.log
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv postgis-2.1.0.tar.gz $TEMPBUILD/tarball
mv postgis-2.1.0 $TEMPBUILD/src

echo "initilalize db"
mkdir -p $PREFIX/pgsql/data

$PREFIX/bin/initdb -D $PREFIX/pgsql/data/
$PREFIX/bin/postmaster -D $PREFIX/pgsql/data >pglogfile 2>&1 &
$PREFIX/bin/pg_ctl -D /home/ecoop/Envs/env1/pgsql/data/ -l logfile start
$PREFIX/bin/createdb test >> pg.log
$PREFIX/bin/psql -f $PREFIX/share/postgresql/contrib/postgis-2.1/postgis.sql -d test >> pg.log
$PREFIX/bin/psql -f /home/$USER/Envs/env1/share/postgresql/contrib/postgis-2.1/spatial_ref_sys.sql -d test >> pg.log/env1/share/postgresql/contrib/postgis-2.1/spatial_ref_sys.sql -d test >> pg.log
