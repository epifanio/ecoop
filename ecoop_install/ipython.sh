#!/bin/bash -l

export LD_LIBRARY_PATH=/home/$USER/Envs/env1/grass-7.0.svn/lib:$LD_LIBRARY_PATH
export PYTHONPATH=/home/$USER/Envs/env1/grass-7.0.svn/etc/python:$PYTHONPATH
export GISBASE="/home/$USER/Envs/env1/grass-7.0.svn/"
export PATH="$PATH:$GISBASE/bin:$GISBASE/scripts"

export GIS_LOCK=$$

mkdir -p /home/$USER/Envs/grass7data
mkdir -p /home/$USER/Envs/.grass7

export GISRC=/home/$USER/Envs/.grass7/rc

export GISDBASE=/home/$USER/Envs/grass7data

export GRASS_TRANSPARENT=TRUE
export GRASS_TRUECOLOR=TRUE
export GRASS_PNG_COMPRESSION=9
export GRASS_PNG_AUTO_WRITE=TRUE

# --deep-reload
# --ip=10.240.133.36 --port=8888

ipython notebook --pylab=inline --ipython-dir=/home/$USER/Envs/env1/.ipython --profile=default --notebook-dir=/home/$USER/Envs/notebooks/ --no-browser --script