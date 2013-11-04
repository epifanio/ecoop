#!/bin/bash -l







EPIENV=/home/$USER/Envs/env1/



mkdir -p $EPIENV/grass7data
mkdir -p $EPIENV/.grass7
export GISRC=$EPIENV/.grass7/rc


GRASS_LIB=$EPIENV/grass-7.0.svn/lib
PYTHONGRASS=$EPIENV/grass-7.0.svn/etc/python


export GISBASE=$EPIENV/grass-7.0.svn/"
export LD_LIBRARY_PATH=$GRASS_LIB:$LD_LIBRARY_PATH
export PYTHONPATH=$PYTHONGRASS:$PYTHONPATH

export PATH="$PATH:$EPIENV/bin:$GISBASE/bin:$GISBASE/scripts"

export GIS_LOCK=$$

#mkdir -p $HOME/grass7data
mkdir -p $HOME/.grass7
export GISRC=$HOME/.grass7/rc

export GISDBASE=$EPIENV/grass7data

export GRASS_TRANSPARENT=TRUE
export GRASS_TRUECOLOR=TRUE
export GRASS_PNG_COMPRESSION=9
export GRASS_PNG_AUTO_WRITE=TRUE

# --deep-reload
# --ip=10.240.133.36 --port=8888

#cd /Users/epifanio/notebooks

nohup /home/epifanio/Envs/env1/bin/ipython notebook --pylab=inline --profile=default --notebook-dir=/home/epifanio/esr_notebooks --no-browser --script --pprint --port=8888 --ip=128.113.106.180 &

marshall, jin lin