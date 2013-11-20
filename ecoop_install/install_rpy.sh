CURRENTDIR=${PWD}
BUILD=epilib
PREFIX=/home/$USER/Envs/env1


export PATH=$PREFIX/bin/
echo "installing rpy2"
$PREFIX/bin/pip install rpy2  >> pip.log

cd $CURRENTDIR

