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
    ./install_epilib /home/localenv
```


NOTE :

* The script has to download and uncompress a 1.5GB tar.gz file.

* The development is in “alpha” state, i’m actively working on its improvement to correct bugs, add new features/tools, improve documentations etc ..
If you find bugs or if you think of a missed, please open an issue. 
