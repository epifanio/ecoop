#!/bin/bash -l

export LD_LIBRARY_PATH=/home/epifanio/Envs/env1/grass-7.0.svn/lib:$LD_LIBRARY_PATH
export PYTHONPATH=/home/epifanio/Envs/env1/grass-7.0.svn/etc/python:$PYTHONPATH
export GISBASE="/home/epifanio/Envs/env1/grass-7.0.svn/"
export PATH="$PATH:$GISBASE/bin:$GISBASE/scripts"
export GIS_LOCK=$$

mkdir -p $HOME/grass7data
mkdir -p $HOME/.grass7

export GISRC=$HOME/.grass7/rc

export GISDBASE=/home/$USER/grass7data

export GRASS_TRANSPARENT=TRUE
export GRASS_TRUECOLOR=TRUE
export GRASS_PNG_COMPRESSION=9
export GRASS_PNG_AUTO_WRITE=TRUE


nohup /home/epifanio/Envs/env1/bin/ipython notebook --profile=jin
nohup /home/epifanio/Envs/env1/bin/ipython notebook --pylab=inline --profile=lin
nohup /home/epifanio/Envs/env1/bin/ipython notebook --pylab=inline --profile=marshall
