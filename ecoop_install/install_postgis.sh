TEMPBUILD=/home/$USER/centos_build
mkdir -p $TEMPBUILD
mkdir -p $TEMPBUILD/tarball
mkdir -p $TEMPBUILD/src

cd $TEMPBUILD 
export PATH=/home/$USER/Envs/env1/bin:$PATH

echo "installing postgis"
wget http://download.osgeo.org/postgis/source/postgis-2.1.0.tar.gz
tar -zxf postgis-2.1.0.tar.gz
cd postgis-2.1.0
./configure --prefix=/home/$USER/Envs/env1/ --with-projdir=/home/$USER/Envs/env1/ --with-gdalconfig=/home/$USER/Envs/env1/bin/gdal-config --with-projdir=/home/$USER/Envs/env1/ >> ../postgis_configure.log
make -j 8 >> ../postgis_build.log
make install >> ../postgis_install.log
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv postgis-2.1.0.tar.gz $TEMPBUILD/tarball
mv postgis-2.1.0 $TEMPBUILD/src

echo "initilalize db"
mkdir -p /home/$USER/Envs/env1/pgsql/data

/home/$USER/Envs/env1/bin/initdb -D /home/$USER/Envs/env1/pgsql/data/
/home/$USER/Envs/env1/bin/postmaster -D /home/$USER/Envs/env1/pgsql/data >pglogfile 2>&1 &
/home/$USER/Envs/env1/bin/pg_ctl -D /home/ecoop/Envs/env1/pgsql/data/ -l logfile start
/home/$USER/Envs/env1/bin/createdb test >> pg.log
/home/$USER/Envs/env1/bin/psql -f /home/$USER/Envs/env1/share/postgresql/contrib/postgis-2.1/postgis.sql -d test >> pg.log
/home/$USER/Envs/env1/bin/psql -f /home/$USER/Envs/env1/share/postgresql/contrib/postgis-2.1/spatial_ref_sys.sql -d test >> pg.log/env1/share/postgresql/contrib/postgis-2.1/spatial_ref_sys.sql -d test >> pg.log