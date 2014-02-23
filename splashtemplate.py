def makeSplash(splash, key):
    title = splash[key]['title']
    description = splash[key]['description']
    credits = splash[key]['credits']
    home = splash[key]['home'] 
    sourcedata = splash[key]['sourcedata']
    nbviewer = splash[key]['nbviewer']
    repository = splash[key]['repository']
    download = splash[key]['download']
    template = """{
     "metadata": {
      "name": "",
      "signature": ""
     },
     "nbformat": 3,
     "nbformat_minor": 0,
     "worksheets": [
      {
       "cells": [
        {
         "cell_type": "markdown",
         "metadata": {},
         "source": [
          "<!DOCTYPE html>\\n",
          "    <html>\\n",
          "    <body>\\n",
          "        <div style=\\"background-image:url(http://www.floridasportsman.com/files/2013/02/noaa-logo1.png);padding:5px;width:100%%;height:230px;border:1px solid white;background-repeat:no-repeat;\\">\\n",
          "        </div>\\n",
          "        <br>\\n",
          "        <h3><b>%s</b><br></h3>\\n",
          "        <div> \\n",
          "            <br>\\n",
          "            %s\\n",
          "            <br>\\n",
          "            <br>\\n",
          "            %s\\n",
          "            <br>\\n",
          "            <br>\\n",
          "                <li><a href=\\"%s\\" target=\\"_blank\\" >%s</a></li>\\n",
          "            <br>\\n",
          "                <li><a href=\\"%s\\" target=\\"_blank\\" >%s</a></li>\\n",
          "            <br>\\n",
          "        </div>\\n",
          "        <hr>\\n",
          "        <br>\\n",
          "        <div>\\n",
          "            <b>Source code used in the IPython Notebook session</b>\\n",
          "            <br> \\n",
          "            <br> \\n",
          "            <li><a href=\\"%s\\" target=\\"_blank\\" >IPython Notebook</a></li>\\n",
          "            <br> \\n",
          "            <li><a href=\\"%s\\" target=\\"_blank\\" >Code repository</a></li>\\n",
          "            <br>\\n",
          "            <li><a href=\\"%s\\" target=\\"_blank\\" >Downloads</a></li>\\n",
          "            <br>\\n",
          "        </div>\\n",
          "    </body>\\n",
          "    </html>"
         ]
        }
       ],
       "metadata": {}
      }
     ]
    }""" % (title, description, credits, home[0], home[1], sourcedata[0],sourcedata[1], nbviewer, repository, download)
    return template