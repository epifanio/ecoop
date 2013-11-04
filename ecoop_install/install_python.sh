# PYTHON

BUILD=epilib
PREFIX=/home/$USER/Envs/env1

TEMPBUILD=/home/$USER/$BUILD
mkdir -p $TEMPBUILD
mkdir -p $TEMPBUILD/tarball
mkdir -p $TEMPBUILD/src

cd $TEMPBUILD 
export PATH=$PREFIX/bin:$PATH

wget http://python.org/ftp/python/2.7.5/Python-2.7.5.tar.bz2
tar xf Python-2.7.5.tar.bz2
cd Python-2.7.5
./configure --prefix=$PREFIX >> ../python_configure.log
make -j 8 >> ../python_build.log
make altinstall >> ../python_install.log
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv Python-2.7.5.tar.bz2 $TEMPBUILD/tarball
mv Python-2.7.5 $TEMPBUILD/src

export PATH=$PREFIX/bin:$PATH

ln -s $PREFIX/bin/python2.7 $PREFIX/bin/python
wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
$PREFIX/bin/python2.7 ez_setup.py
mv ez_setup.py $TEMPBUILD/tarball
mv setuptools-* $TEMPBUILD/src

echo "installing pip"
$PREFIX/bin/easy_install-2.7 pip 
echo "installing virtualenv"
$PREFIX/bin/pip install virtualenv 
echo "installing setuptools"
$PREFIX/bin/pip install setuptools >> pip.log
echo "installing dateutils"
$PREFIX/bin/pip install dateutils  >> pip.log
echo "installing docutils"
$PREFIX/bin/pip install docutils  >> pip.log
echo "installing jinja2"
$PREFIX/bin/pip install jinja2  >> pip.log
echo "installing nose"
$PREFIX/bin/pip install nose  >> pip.log
echo "installing numpy"
$PREFIX/bin/pip install numpy  >> pip.log
echo "installing paramiko"
$PREFIX/bin/pip install paramiko  >> pip.log
echo "installing PIL"
$PREFIX/bin/pip install PIL  >> pip.log
echo "installing pygments"
$PREFIX/bin/pip install pygments  >> pip.log 
echo "installing scipy"
$PREFIX/bin/pip install scipy  >> pip.log
echo "installing sphinx"
$PREFIX/bin/pip install sphinx  >> pip.log
echo "installing matplotlib"
$PREFIX/bin/pip install matplotlib  >> pip.log
echo "installing pyzmq"
$PREFIX/bin/pip install pyzmq  >> pip.log
echo "installing tornado"
$PREFIX/bin/pip install tornado  >> pip.log
echo "installing envoy"
$PREFIX/bin/pip install envoy  >> pip.log
echo "installing qrcode"
$PREFIX/bin/pip install qrcode  >> pip.log


cd $TEMPBUILD
wget http://www.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.8.11.tar.gz
tar -zxf hdf5-1.8.11.tar.gz 
cd hdf5-1.8.11
./configure --prefix=$PREFIX/ --enable-shared --enable-hl >> ../hdf5_configure.log
make -j 8 >> ../hdf5_build.log
make install >> ../hdf5_install.log
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv hdf5-1.8.11.tar.gz $TEMPBUILD/tarball
mv hdf5-1.8.11 $TEMPBUILD/src
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4.3.0.tar.gz
tar -zxf netcdf-4.3.0.tar.gz
cd netcdf-4.3.0
LDFLAGS=-L$PREFIX/lib CPPFLAGS=-I$PREFIX/include ./configure --enable-netcdf-4 --enable-dap --enable-shared --prefix=$PREFIX >> ../netcdf_configure.log
make -j 8 >> ../netcdf_build.log
make install >> ../netcdf_install.log
make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv netcdf-4.3.0.tar.gz $TEMPBUILD/tarball
mv netcdf-4.3.0 $TEMPBUILD/src


wget ftp://ftp.unidata.ucar.edu/pub/udunits/udunits-2.1.24.tar.gz
tar -zxf udunits-2.1.24.tar.gz
cd udunits-2.1.24
./configure --prefix=$PREFIX >> ../udunits_configure.log
make -j 8
make install
cd $TEMPBUILD
mv udunits-2.1.24.tar.gz $TEMPBUILD/tarball
mv udunits-2.1.24 $TEMPBUILD/src


svn checkout http://netcdf4-python.googlecode.com/svn/trunk/ netcdf4-python
cd netcdf4-python
export HDF5_DIR=$PREFIX/
export NETCDF4_DIR=$PREFIX/
$PREFIX/bin/python setup.py install >> ../pyinstall.log
rm -rf build
cd $TEMPBUILD
mv netcdf4-python $TEMPBUILD/src

echo "installing h5py"
$PREFIX/bin/pip install h5py >> pip.log
echo "installing numexpr"
$PREFIX/bin/pip install numexpr >> pip.log
echo "installing Cython"
$PREFIX/bin/pip install Cython >> pip.log
echo "installing tables"
$PREFIX/bin/pip install tables >> pip.log
echo "installing pandas"
$PREFIX/bin/pip install pandas >> pip.log
echo "installing patsy"
$PREFIX/bin/pip install patsy >> pip.log
echo "installing pysal"
$PREFIX/bin/pip install pysal >> pip.log
echo "installing statsmodels"
$PREFIX/bin/pip install statsmodels  >> pip.log
echo "installing pyke"
$PREFIX/bin/pip install pyke  >> pip.log
echo "installing mock"
$PREFIX/bin/pip install mock  >> pip.log


wget --no-check-certificate -c --progress=dot:mega \
  "https://software.ecmwf.int/wiki/download/attachments/3473437/grib_api-1.9.16.tar.gz"
tar xzf grib_api-1.9.16.tar.gz

cd grib_api-1.9.16
export CFLAGS="-O2 -fPIC"
./configure --enable-python --prefix=$PREFIX/
make -j 8
make install
make distclean
mv grib_api-1.9.16.tar.gz $TEMPBUILD/tarball 
mv grib_api-1.9.16 $TEMPBUILD/src

echo "$PREFIX/lib/python2.7/site-packages/grib_api" > gribapi.pth
cp gribapi.pth $PREFIX/lib/python2.7/site-packages/


git clone https://github.com/ipython/ipython
cd ipython
$PREFIX/bin/python setup.py install >> ../pyinstall.log
rm -rf build
cd $TEMPBUILD
mv ipython $TEMPBUILD/src

ipython profile create default
ipython profile create ecoop --ipython-dir=$PREFIX/.ipython --parallel

mkdir -p /home/$USER/Envs/notebooks/
cp ipython.sh $PREFIX/bin  /home/$USER/Envs/notebooks/
