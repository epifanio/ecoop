# coding: utf-8

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


__author__ = 'epi'


indicator = {}
NAO = indicator['NAO_ID'] = {}
NAO['indicatorID'] = ''
NAO['title'] = ''
NAO['creator'] = ''
NAO['subject'] = ''
NAO['description'] = ''
NAO['publisher'] = ''
NAO['contributor'] = ''
NAO['time'] = ''
NAO['type'] = ''
NAO['format'] = ''
NAO['identifier'] = ''
NAO['source'] = ''
NAO['language'] = ''
NAO['relation'] = ''
NAO['coverage'] = ''


AMO = indicator['AMO_ID'] = {}
AMO['indicatorID'] = ''
AMO['title'] = ''
AMO['creator'] = ''
AMO['subject'] = ''
AMO['description'] = ''
AMO['publisher'] = ''
AMO['contributor'] = ''
AMO['time'] = ''
AMO['type'] = ''
AMO['format'] = ''
AMO['identifier'] = ''
AMO['source'] = ''
AMO['language'] = ''
AMO['relation'] = ''
AMO['coverage'] = ''



persons = {}

USER1 = persons['username1'] = {}
USER1['personID'] = ''
USER1['department'] = ''
USER1['firstname'] = ''
USER1['lastname'] = ''
USER1['address'] = ''
USER1['phone'] = ''
USER1['mail'] = ''
USER1['homepage'] = ''
USER1['uri'] = ''


USER2 = persons['username2'] = {}
USER2['personID'] = ''
USER2['department'] = ''
USER2['firstname'] = ''
USER2['lastname'] = ''
USER2['address'] = ''
USER2['phone'] = ''
USER2['mail'] = ''
USER2['homepage'] = ''
USER2['uri'] = ''

USER3 = persons['username3'] = {}
USER3['personID'] = ''
USER3['department'] = ''
USER3['firstname'] = ''
USER3['lastname'] = ''
USER3['address'] = ''
USER3['phone'] = ''
USER3['mail'] = ''
USER3['homepage'] = ''
USER3['uri'] = ''

USER4 = persons['username4'] = {}
USER4['personID'] = ''
USER4['department'] = ''
USER4['firstname'] = ''
USER4['lastname'] = ''
USER4['address'] = ''
USER4['phone'] = ''
USER4['mail'] = ''
USER4['homepage'] = ''
USER4['uri'] = ''


sessions = {}

D = sessions['sessionID'] = {}
D['sessionID'] = ''
D['sessionName'] = ''
D['URI'] = ''
D['parentID'] = ''

P = sessions['sessionID'] = {}
P['sessionID'] = ''
P['sessionName'] = ''
P['URI'] = ''
P['parentID'] = ''

departments = {}

DEP1 = departments['departmentID1'] = {}
DEP1['departmentID'] = ''
DEP1['type'] = ''
DEP1['name'] = ''
DEP1['address'] = ''
DEP1['location'] = ''
DEP1['postalcode'] = ''
DEP1['country'] = ''
DEP1['uri'] = ''
DEP1['belongsto'] = ''
DEP1['homepage'] = ''



DEP2 = departments['departmentID2'] = {}
DEP2['departmentID'] = ''
DEP2['type'] = ''
DEP2['name'] = ''
DEP2['address'] = ''
DEP2['location'] = ''
DEP2['postalcode'] = ''
DEP2['country'] = ''
DEP2['uri'] = ''
DEP2['belongsto'] = ''
DEP2['homepage'] = ''

ONTO = {}
ONTO['indicator'] = indicator
ONTO['persons'] = persons
ONTO['sessions'] = sessions
ONTO['departments'] = departments

#print ONTO.keys()

#for i in ONTO.keys():
#    print i, ' :', ONTO[i].keys()