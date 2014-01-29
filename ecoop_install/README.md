## Installation instruction

* download the following scripts on a linux machine (CentOS 6.x 64 - bit) :

    [yuminstall.sh](https://raw.github.com/epifanio/ecoop/master/ecoop_install/yuminstall.sh)

    [install_epilib.sh](wget https://raw.github.com/epifanio/ecoop/master/ecoop_install/install_epilib.sh)

* install main dependecies (log in as  ROOT)
    
```
    su
    #password for root
    # make the script yuminstall.sh “executable” 
    chmod a+x yuminstall.sh
    # run the script :
    ./yuminstall.sh
    exit
```

* download and install the local environment (log in as non-root USER) 

* chose a directory where you want the local environment installed, better if the directory is accessible from more users e.g.:  /home/localenv  (be sure the directory exist and is writable)

* run the script giving the insgtallation PATH as argument :

```
    ./install_epilib.sh /home/localenv
```

### The installation script  add a *Crontab instruction* to run the IPython notebook service at each reboot

## Configuration :

By default the notebook server use a *default profile* , the user can customize the configuration defining custom profiles and updating the run-script located in 

```
    Installation-PATH/Envs/env1/bin/ipython.sh
```

* documentation on how to create and customize a new profile are available   [here](http://ipython.org/ipython-doc/rel-1.1.0/interactive/public_server.html)

NOTE :

* The script has to download and uncompress a 1.5GB tar.gz file.

* The development is in “alpha” state, i’m actively working on its improvement to correct bugs, add new features/tools, improve documentations etc ..
If you find bugs or if you think of a missed, please open an issue. 
