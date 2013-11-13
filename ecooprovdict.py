# coding: utf-8
ecooProvDict = {}

ecooProvDict['IPythonNotebook'] = {}
ecooProvDict['IPythonNotebook']['title'] = ''
ecooProvDict['IPythonNotebook']['description'] = ''
ecooProvDict['IPythonNotebook']['accessURL'] = ''


ecooProvDict['IPythonNotebookRun'] = {}
ecooProvDict['IPythonNotebookRun']['description'] = ''
ecooProvDict['IPythonNotebookRun']['startedAtTime'] = ''
ecooProvDict['IPythonNotebookRun']['endedAtTime'] = ''
ecooProvDict['IPythonNotebookRun']['wasAssociatedWith'] = ''


ecooProvDict['Cell'] = {}
ecooProvDict['Cell']['title'] = ''
ecooProvDict['Cell']['description'] = ''
ecooProvDict['Cell']['accessURL'] = ''

ecooProvDict['CellRun'] = {}
ecooProvDict['CellRun']['title'] = ''
ecooProvDict['CellRun']['description'] = ''
ecooProvDict['CellRun']['startedAtTime'] = ''
ecooProvDict['CellRun']['endedAtTime'] = ''
ecooProvDict['CellRun']['wasAssociatedWith'] = ''


ecooProvDict['Document'] = {}
ecooProvDict['Document']['title'] = ''
ecooProvDict['Document']['description'] = ''
ecooProvDict['Document']['downloadURL'] = ''


ecooProvDict['Dataset'] = {}
ecooProvDict['Dataset']['agent'] = ''
ecooProvDict['Dataset']['title'] = ''
ecooProvDict['Dataset']['description'] = ''
ecooProvDict['Dataset']['distribution'] = {}
ecooProvDict['Dataset']['distribution']'title'] = ''
ecooProvDict['Dataset']['distribution']['description'] = ''
ecooProvDict['Dataset']['distribution']['accessURL'] = ''
ecooProvDict['Dataset']['distribution']['downloadURL'] = ''
ecooProvDict['Dataset']['wasAttributedTo'] = ''

ecooProvDict['Dataset']['identifier'] = ''
ecooProvDict['Dataset']['license'] = {}
ecooProvDict['Dataset']['license']['LicenseDocument'] = ''
ecooProvDict['Dataset']['license']['MediaTypeOrExtent'] = ''
ecooProvDict['Dataset']['license']['LinguisticSystem'] = ''
ecooProvDict['Dataset']['format'] = ''
ecooProvDict['Dataset']['language'] = ''
ecooProvDict['Dataset']['byteSize'] = ''
ecooProvDict['Dataset']['generatedAtTime'] = ''
ecooProvDict['Dataset']['issued'] = ''
ecooProvDict['Dataset']['modified'] = ''
ecooProvDict['Dataset']['contactpoint'] = ''

ecooProvDict['Dataset']['SpatialExtents'] = {}
ecooProvDict['Dataset']['SpatialExtents']['extentTypeCode'] = ''
ecooProvDict['Dataset']['SpatialExtents']['westBoundLongitude'] = ''
ecooProvDict['Dataset']['SpatialExtents']['eastBoundLongitude'] = ''
ecooProvDict['Dataset']['SpatialExtents']['southBoundLatitude'] = ''
ecooProvDict['Dataset']['SpatialExtents']['northBoundLatitude'] = ''

ecooProvDict['Dataset']['TemporalExtens'] = {}
ecooProvDict['Dataset']['TemporalExtens']['startedAtTime'] = ''
ecooProvDict['Dataset']['TemporalExtens']['endedAtTime'] = ''

ecooProvDict['Dataset']['SpatialResolution'] = {}
ecooProvDict['Dataset']['SpatialResolution']['resolution'] = ''
ecooProvDict['Dataset']['SpatialResolution']['equivalentScale'] = ''

ecooProvDict['Dataset']['TemporalResolution'] = {}
ecooProvDict['Dataset']['TemporalResolution']['temporalUnit'] = ''

"""
ecooProvDict['Dataset']['TemporalResolution']['temporalUnit'] = {}
ecooProvDict['Dataset']['TemporalResolution']['temporalUnit']['unitYear'] = ''
ecooProvDict['Dataset']['TemporalResolution']['temporalUnit']['unitMonth'] = ''
ecooProvDict['Dataset']['TemporalResolution']['temporalUnit']['unitWeek'] = ''
ecooProvDict['Dataset']['TemporalResolution']['temporalUnit']['unitDay'] = ''
ecooProvDict['Dataset']['TemporalResolution']['temporalUnit']['unitHour'] = ''
ecooProvDict['Dataset']['TemporalResolution']['temporalUnit']['unitMinute'] = ''
ecooProvDict['Dataset']['TemporalResolution']['temporalUnit']['unitSecond'] = ''
"""

"""
ecooProvDict['Dataset']['instrument'] = ''
ecooProvDict['Dataset']['algorithm'] = ''
ecooProvDict['Dataset']['model'] = ''

ecooProvDict['Dataset']['dataCenter'] = {}
ecooProvDict['Dataset']['dataCenter']['group'] = ''
ecooProvDict['Dataset']['dataCenter']['organization'] = ''
"""



ecooProvDict['Person'] = {}
ecooProvDict['Person']['name'] = ''
ecooProvDict['Person']['familyName'] = ''
ecooProvDict['Person']['givenName'] = ''
ecooProvDict['Person']['mbox'] = ''
ecooProvDict['Person']['phone'] = ''
ecooProvDict['Person']['address'] = ''
ecooProvDict['Person']['homepageURL'] = ''
ecooProvDict['Person']['isMemberOf'] = {}
ecooProvDict['Person']['isMemberOf']['Organization'] = ''
ecooProvDict['Person']['isMemberOf']['Group'] = ''



ecooProvDict['Organization'] = {}
ecooProvDict['Organization']['name'] = ''
ecooProvDict['Organization']['mbox'] = ''
ecooProvDict['Organization']['phone'] = ''
ecooProvDict['Organization']['address'] = ''
ecooProvDict['Organization']['homepageURL'] = ''
ecooProvDict['Organization']['hasMemberOf']['Person'] = ''
ecooProvDict['Organization']['hasMemberOf']['Group'] = ''


ecooProvDict['Group'] = {}
ecooProvDict['Group']['name'] = ''
ecooProvDict['Group']['mbox'] = ''
ecooProvDict['Group']['phone'] = ''
ecooProvDict['Group']['address'] = ''
ecooProvDict['Group']['homepageURL'] = ''
ecooProvDict['Group']['hasMemberOf']['Person'] = ''
ecooProvDict['Group']['hasMemberOf']['Group'] = ''
ecooProvDict['Group']['isMemberOf']['Organization'] = ''



ecooProvDict['Library'] = {}
ecooProvDict['Library']['title'] = ''
ecooProvDict['Library']['description'] = ''
ecooProvDict['Library']['accessURL'] = ''
ecooProvDict['Library']['wasAttributedTo'] = ''

