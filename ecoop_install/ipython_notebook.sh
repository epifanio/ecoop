#!/bin/bash -l

export LD_LIBRARY_PATH=$1grass-7.0.svn/lib:$LD_LIBRARY_PATH
export PYTHONPATH=$1grass-7.0.svn/etc/python:$PYTHONPATH
export GISBASE=$1grass-7.0.svn/
export PATH=$PATH:$GISBASE/bin:$GISBASE/scripts

export GIS_LOCK=$$

mkdir -p $1Envs/grass7data
mkdir -p $1Envs/.grass7

export GISRC=$1Envs/.grass7/rc

export GISDBASE=$1Envs/grass7data

export GRASS_TRANSPARENT=TRUE
export GRASS_TRUECOLOR=TRUE
export GRASS_PNG_COMPRESSION=9
export GRASS_PNG_AUTO_WRITE=TRUE

export ORACLE_HOME=$1oracle/product/11.2.0/xe/
export LD_LIBRARY_PATH=$1oracle/product/11.2.0/xe/lib:$LD_LIBRARY_PATH
export PATH=$1oracle/product/11.2.0/xe:$1Envs/env1/bin:$1Envs/env1/cabal/bin:$PATH

ipython notebook --pylab=inline --ipython-dir=$1Envs/env1/.ipython --profile=default --notebook-dir=$1Envs/notebooks/ --no-browser --script
