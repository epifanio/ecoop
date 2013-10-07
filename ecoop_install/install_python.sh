# PYTHON

TEMPBUILD=/home/$USER/centos_build
mkdir -p $TEMPBUILD
mkdir -p $TEMPBUILD/tarball
mkdir -p $TEMPBUILD/src

cd $TEMPBUILD 
export PATH=/home/$USER/Envs/env1/bin:$PATH

wget http://python.org/ftp/python/2.7.5/Python-2.7.5.tar.bz2
tar xf Python-2.7.5.tar.bz2
cd Python-2.7.5
./configure --prefix=/home/$USER/Envs/env1 >> ../python_configure.log
make -j 8 >> ../python_build.log
make altinstall >> ../python_install.log
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv Python-2.7.5.tar.bz2 $TEMPBUILD/tarball
mv Python-2.7.5 $TEMPBUILD/src

export PATH=/home/$USER/Envs/env1/bin:$PATH

ln -s /home/$USER/Envs/env1/bin/python2.7 /home/$USER/Envs/env1/bin/python
wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
/home/$USER/Envs/env1/bin/python2.7 ez_setup.py
mv ez_setup.py $TEMPBUILD/tarball
mv setuptools-* $TEMPBUILD/src

echo "installing pip"
/home/$USER/Envs/env1/bin/easy_install-2.7 pip 
echo "installing virtualenv"
/home/$USER/Envs/env1/bin/pip install virtualenv 
echo "installing setuptools"
/home/$USER/Envs/env1/bin/pip install setuptools >> pip.log
echo "installing dateutils"
/home/$USER/Envs/env1/bin/pip install dateutils  >> pip.log
echo "installing docutils"
/home/$USER/Envs/env1/bin/pip install docutils  >> pip.log
echo "installing jinja2"
/home/$USER/Envs/env1/bin/pip install jinja2  >> pip.log
echo "installing nose"
/home/$USER/Envs/env1/bin/pip install nose  >> pip.log
echo "installing numpy"
/home/$USER/Envs/env1/bin/pip install numpy  >> pip.log
echo "installing paramiko"
/home/$USER/Envs/env1/bin/pip install paramiko  >> pip.log
echo "installing PIL"
/home/$USER/Envs/env1/bin/pip install PIL  >> pip.log
echo "installing pygments"
/home/$USER/Envs/env1/bin/pip install pygments  >> pip.log 
echo "installing scipy"
/home/$USER/Envs/env1/bin/pip install scipy  >> pip.log
echo "installing sphinx"
/home/$USER/Envs/env1/bin/pip install sphinx  >> pip.log
echo "installing matplotlib"
/home/$USER/Envs/env1/bin/pip install matplotlib  >> pip.log
echo "installing pyzmq"
/home/$USER/Envs/env1/bin/pip install pyzmq  >> pip.log
echo "installing tornado"
/home/$USER/Envs/env1/bin/pip install tornado  >> pip.log
echo "installing envoy"
/home/$USER/Envs/env1/bin/pip install envoy  >> pip.log
echo "installing qrcode"
/home/$USER/Envs/env1/bin/pip install qrcode  >> pip.log


cd $TEMPBUILD
wget http://www.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.8.11.tar.gz
tar -zxf hdf5-1.8.11.tar.gz 
cd hdf5-1.8.11
./configure --prefix=/home/$USER/Envs/env1/ --enable-shared --enable-hl >> ../hdf5_configure.log
make -j 8 >> ../hdf5_build.log
make install >> ../hdf5_install.log
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv hdf5-1.8.11.tar.gz $TEMPBUILD/tarball
mv hdf5-1.8.11 $TEMPBUILD/src
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4.3.0.tar.gz
tar -zxf netcdf-4.3.0.tar.gz
cd netcdf-4.3.0
LDFLAGS=-L/home/$USER/Envs/env1/lib CPPFLAGS=-I/home/$USER/Envs/env1/include ./configure --enable-netcdf-4 --enable-dap --enable-shared --prefix=/home/$USER/Envs/env1 >> ../netcdf_configure.log
make -j 8 >> ../netcdf_build.log
make install >> ../netcdf_install.log
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv netcdf-4.3.0.tar.gz $TEMPBUILD/tarball
mv netcdf-4.3.0 $TEMPBUILD/src


wget ftp://ftp.unidata.ucar.edu/pub/udunits/udunits-2.1.24.tar.gz
tar -zxf udunits-2.1.24.tar.gz
cd udunits-2.1.24
./configure --prefix=/home/$USER/Envs/env1 >> ../udunits_configure.log
make -j 8
make install
cd $TEMPBUILD
mv udunits-2.1.24.tar.gz $TEMPBUILD/tarball
mv udunits-2.1.24 $TEMPBUILD/src


svn checkout http://netcdf4-python.googlecode.com/svn/trunk/ netcdf4-python
cd netcdf4-python
export HDF5_DIR=/home/$USER/Envs/env1/
export NETCDF4_DIR=/home/$USER/Envs/env1/
/home/$USER/Envs/env1/bin/python setup.py install >> ../pyinstall.log
rm -rf build
cd $TEMPBUILD
mv netcdf4-python $TEMPBUILD/src

echo "installing h5py"
/home/$USER/Envs/env1/bin/pip install h5py >> pip.log
echo "installing tables"
/home/$USER/Envs/env1/bin/pip install tables >> pip.log
echo "installing pandas"
/home/$USER/Envs/env1/bin/pip install pandas >> pip.log
echo "installing patsy"
/home/$USER/Envs/env1/bin/pip install patsy >> pip.log
echo "installing pysal"
/home/$USER/Envs/env1/bin/pip install pysal >> pip.log
echo "installing statsmodels"
/home/$USER/Envs/env1/bin/pip install statsmodels  >> pip.log
echo "installing pyke"
/home/$USER/Envs/env1/bin/pip install pyke  >> pip.log
echo "installing cython"
/home/$USER/Envs/env1/bin/pip install cython  >> pip.log
echo "installing mock"
/home/$USER/Envs/env1/bin/pip install mock  >> pip.log


wget --no-check-certificate -c --progress=dot:mega \
  "https://software.ecmwf.int/wiki/download/attachments/3473437/grib_api-1.9.16.tar.gz"
tar xzf grib_api-1.9.16.tar.gz

cd grib_api-1.9.16
export CFLAGS="-O2 -fPIC"
./configure --enable-python --prefix=/home/$USER/Envs/env1/
make -j 8
make install
make distclean
mv grib_api-1.9.16.tar.gz $TEMPBUILD/tarball 
mv grib_api-1.9.16 $TEMPBUILD/src

echo "/home/$USER/Envs/env1/lib/python2.7/site-packages/grib_api" > gribapi.pth
cp gribapi.pth /home/$USER/Envs/env1/lib/python2.7/site-packages/


git clone https://github.com/ipython/ipython
cd ipython
/home/$USER/Envs/env1/bin/python setup.py install >> ../pyinstall.log
rm -rf build
cd $TEMPBUILD
mv ipython $TEMPBUILD/src

ipython profile create default
ipython profile create ecoop --ipython-dir=/home/$USER/Envs/env1/.ipython --parallel