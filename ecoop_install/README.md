## Instruction

---

####Basic Installation to test the Climate Forcing notebook :

* Download and install the ecoop code and its dependencies
    
    ```
    wget http://udoo.whoi.edu/shared/ecoop-0.0.1.tar.gz
    tar -zxvf ecoop-0.0.1.tar.gz
    cd ecoop-0.0.1
    pip install -r requirement.txt
    python setup.py install
    cd ..
    ```

*  pdflatex<br>

    ```
    apt-get install texlive texlive-latex-extra      
    ```
      
* gist utility:

    ```
    apt-get install rubygems
    gem install gist
    ```




---

####Full installation 



Local environment that includes a complete set of tool and libraries to work with R-GRASS-Scientiphic Python and more


* download the following scripts on a linux machine (CentOS 6.x 64 - bit) :

    [yuminstall.sh](https://raw.github.com/epifanio/ecoop/master/ecoop_install/yuminstall.sh)

    [install_epilib.sh](https://raw.github.com/epifanio/ecoop/master/ecoop_install/install_epilib.sh)

```
wget https://raw.github.com/epifanio/ecoop/master/ecoop_install/yuminstall.sh
wget https://raw.github.com/epifanio/ecoop/master/ecoop_install/install_epilib.sh
```

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


```
sudo mkdir localenv
sudo chmod -r 777 localenv
```


* run the script giving the insgtallation PATH as argument :

```
chmod a+x install_epilib.sh
./install_epilib.sh /home/localenv
```

### Start/Stop the service :

The installation script  add a *Crontab instruction* to run the IPython notebook service at each reboot.
To start the service manually run :

```
nohup sh Installation-PATH/Envs/env1/bin/ipython.sh &
```
to stop :
```
pkill -9 ipython.sh
```

* The default service will be available on [localhost](http://localhost:8888) on port 8888

NOTE :

* The script has to download and uncompress a 1.5GB tar.gz file.

* The development is in “alpha” state, i’m actively working on its improvement to correct bugs, add new features/tools, improve documentations etc ..
If you find bugs or if you think of a missed, please open an issue. 

### Custom Configuration :

The notebook server use a *default profile* , the user can customize the configuration defining a custom profiles and updating the run-script located in 

```
Installation-PATH/Envs/env1/bin/ipython.sh
```

* documentation on how to create and customize a new profile are available   [here](http://ipython.org/ipython-doc/rel-1.1.0/interactive/public_server.html)






