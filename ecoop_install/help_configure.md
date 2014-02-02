* create profile

```
ipython profile create profilename
```

* Add a password :

```
from IPython.lib import passwd
passwd()
Enter password:
Verify password:
# 'sha1:67c9e60bb8b6:9ffede0825894254b2e042ea597d771089e11aed'
```

* Generate an ssl certificate :

```
openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout mycert.pem -out mycert.pem
```

In the profile directory just created, edit the file ipython_notebook_config.py. 
By default, the file has all fields commented; the minimum set you need to uncomment and edit is the following:


```
c = get_config()

# Kernel config
c.IPKernelApp.pylab = 'inline'  # if you want plotting support always

# Notebook config
c.NotebookApp.certfile = u'/absolute/path/to/your/certificate/mycert.pem'
c.NotebookApp.ip = '*' # change this to your server IP
c.NotebookApp.open_browser = False
c.NotebookApp.password = u'sha1:bcd259ccf...[your hashed password here]'
# It is a good idea to put it on a known, fixed port
c.NotebookApp.port = 9999
```




