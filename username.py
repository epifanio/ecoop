import os

###############################################################################
#
#
# Project: ECOOP, sponsored by The National Science Foundation
# Purpose: this code is part of the Cyberinfrastructure developed for the ECOOP project
#                http://tw.rpi.edu/web/project/ECOOP
#                from the TWC - Tetherless World Constellation
#                            at RPI - Rensselaer Polytechnic Institute
#                            founded by NSF
#
# Author:   Massimo Di Stefano , distem@rpi.edu -
#                http://tw.rpi.edu/web/person/MassimoDiStefano
#
###############################################################################
# Copyright (c) 2008-2014 Tetherless World Constellation at Rensselaer Polytechnic Institute
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
###############################################################################


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
