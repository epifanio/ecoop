echo "install python sci*"
./install_python.sh
echo "install gis - basemap"
./install_gis.sh
echo "install SQL"
./install_sql.sh
echo "install gdal"
./install_gdal.sh
#echo "install postgis"
#./install_postgis.sh
echo "install grass"
./install_grass.sh
echo "install "octave""
./install_octave.sh
echo "install R"
./install_R.sh

PREFIX=/home/$USER/Envs/env1

export PATH=$PREFIX/bin:$PATH
R --no-save < installRpackages.r
R --no-save < install_spatial_view.r

cp ipython.sh /home/$USER/Envs/env1/bin/
