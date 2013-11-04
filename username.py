
import os

def checkUsername():
    print ""


import getpass

print getpass.getuser()


print dir(getpass)


print getpass.getpass()


import getpass

username = getpass.getuser()

users = {}
lin = users['lin'] = {}
jin = users['jin'] = {}
marshall = users['marshall'] {}


jin['username'] = 'jin'
jin['password'] = u'sha1:5c74fbef296f:0303440d7990f862aaa8ea44ac8ac7789340925d'
jin['ipython_dir'] = u'/home/epifanio/.ipython'
jin['port'] = 8892

lin['username'] = 'lin'
lin['password'] = u'sha1:4d71f94331d9:355ab829569c6845a972b788e34f5bb8eab14be7'
lin['ipython_dir'] = u'/home/epifanio/.ipython'
lin['port'] = 8891

marshall['username'] = 'marshall'
marshall['password'] = u'sha1:5321e73fc477:421c16a3e611500324ab79c660ed7e782c645461'
marshall['ipython_dir'] = u'/home/epifanio/.ipython'
marshall['port'] = 8890


userconfig = users['marshall']
