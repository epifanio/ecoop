#!/bin/bash -l


PREFIX=/home/$USER/Envs/env1

export LD_LIBRARY_PATH=$PREFIX/grass-7.0.svn/lib:$LD_LIBRARY_PATH
export PYTHONPATH=$PREFIX/grass-7.0.svn/etc/python:$PYTHONPATH
export GISBASE=$PREFIX/grass-7.0.svn/
export PATH=$PATH:$GISBASE/bin:$GISBASE/scripts

export GIS_LOCK=$$

mkdir -p /home/$USER/Envs/grass7data
mkdir -p /home/$USER/Envs/.grass7

export GISRC=/home/$USER/Envs/.grass7/rc

export GISDBASE=/home/$USER/Envs/grass7data

export GRASS_TRANSPARENT=TRUE
export GRASS_TRUECOLOR=TRUE
export GRASS_PNG_COMPRESSION=9
export GRASS_PNG_AUTO_WRITE=TRUE

export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe/
export LD_LIBRARY_PATH=/u01/app/oracle/product/11.2.0/xe/lib:$LD_LIBRARY_PATH
export PATH=/u01/app/oracle/product/11.2.0/xe:/home/$USER/Envs/env1/bin:$PATH


# --deep-reload
# --ip=10.240.133.36 --port=8888

ipython notebook --pylab=inline --ipython-dir=$PREFIX/.ipython --profile=default --notebook-dir=/home/$USER/Envs/notebooks/ --no-browser --script
