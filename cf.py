#!/usr/bin/python

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




import os
import envoy

from datetime import datetime
import numpy as np
import scipy.stats as sts
import statsmodels.api as sm

lowess = sm.nonparametric.lowess
from scipy.interpolate import interp1d
import pandas as pd
import matplotlib.pyplot as plt
from ecooputil import shareUtil as EU
eu = EU()
#eu = shareUtil()
class cfData():
    def __init__(self):
        self.x = ''

    def nao_get(self, url="https://climatedataguide.ucar.edu/sites/default/files/climate_index_files/nao_station_djfm.txt",
                save=None, csvout='nao.csv'):
        """
        read NAO data from url and return a pandas dataframe
        @param url: url to data online default is set to :
                    https://climatedataguide.ucar.edu/sites/default/files/climate_index_files/nao_station_djfm.txt
        @param save: directory where to save raw data as csv
        @return: naodata as pandas dataframe
        """
        try:
            naodata = pd.read_csv(url, sep='  ', header=0, skiprows=0, index_col=0, parse_dates=True, skip_footer=1)
            print 'dataset used: %s', url
            if save:
                eu.ensure_dir(save)
                output = os.path.join(save, csvout)
                naodata.to_csv(output, sep=',', header=True, index=True, index_label='Date')
                print 'nao data saved in :', output
            return naodata
        except IOError:
            print 'unable to fetch the data, check if %s is a valid address and data is conform to AMO spec, for info about data spec. see [1]', url
            # try cached version / history-linked-uri


    def nin_get(self, url='http://www.cpc.ncep.noaa.gov/data/indices/sstoi.indices', save=None, csvout='nin.csv'):
        """
        read NIN data from url and return a pandas dataframe
        @param url: url to data online default is set to : http://www.cpc.ncep.noaa.gov/data/indices/sstoi.indices
        @param save: directory where to save raw data as csv
        @return: nindata as pandas dataframe
        """
        try:
            ts_raw = pd.read_table(url, sep=' ', header=0, skiprows=0, parse_dates=[['YR', 'MON']], skipinitialspace=True,
                                   index_col=0, date_parser=parse)
            print 'dataset used: %s', url
            ts_year_group = ts_raw.groupby(lambda x: x.year).apply(lambda sdf: sdf if len(sdf) > 11 else None)
            ts_range = pd.date_range(ts_year_group.index[0][1], ts_year_group.index[-1][1] + pd.DateOffset(months=1),
                                     freq="M")
            ts = pd.DataFrame(ts_year_group.values, index=ts_range, columns=ts_year_group.keys())
            ts_fullyears_group = ts.groupby(lambda x: x.year)
            nin_anomalies = (ts_fullyears_group.mean()['ANOM.3'] - sts.nanmean(
                ts_fullyears_group.mean()['ANOM.3'])) / sts.nanstd(ts_fullyears_group.mean()['ANOM.3'])
            nin_anomalies = pd.DataFrame(nin_anomalies.values, index=pd.to_datetime([str(x) for x in nin_anomalies.index]))
            nin_anomalies = nin_anomalies.rename(columns={'0': 'nin'})
            nin_anomalies.columns = ['nin']
            if save:
                eu.ensure_dir(save)
                output = os.path.join(save, csvout)
                nin_anomalies.to_csv(output, sep=',', header=True, index=True, index_label='Date')
                print 'data saved as', output
            return nin_anomalies
        except IOError:
            print 'unable to fetch the data, check if %s is a valid address and data is conform to AMO spec, for info about data spec. see [1]', url
            # try cached version / history-linked-uri


    def parse(self, yr, mon):
        """
        Convert year and month to a datatime object, day hardcoded to 2nd day of each month
        @param yr: year date integer or string
        @param mon: month date integer or string
        @return: datatime object (time stamp)
        """
        date = datetime(year=int(yr), day=2, month=int(mon))
        return date


    def amo_get(self, url='http://www.cdc.noaa.gov/Correlation/amon.us.long.data', save=None, csvout='amo.csv'):
        """
        read AMO data from url and return a pandas dataframe
        @param url: url to data online default is set to : http://www.cdc.noaa.gov/Correlation/amon.us.long.data
        @param save: directory where to save raw data as csv
        @return: amodata as pandas dataframe
        """
        try:
            ts_raw = pd.read_table(url, sep=' ', skiprows=1,
                                   names=['year', 'jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct',
                                          'nov', 'dec'], skipinitialspace=True, parse_dates=True, skipfooter=4, index_col=0)
            print 'dataset used: %s', url
            ts_raw.replace(-9.99900000e+01, np.NAN, inplace=True)
            amodata = ts_raw.mean(axis=1)
            amodata.name = "amo"
            amodata = pd.DataFrame(amodata)
            if save:
                eu.ensure_dir(save)
                output = os.path.join(save, csvout)
                amodata.to_csv(output, sep=',', header=True, index=True, index_label='Date')
                print 'data saved as', output
            return amodata
        except:
            print 'doh'
            print 'unable to fetch the data, check if %s is a valid address and data is conform to AMO spec, for info about data spec. see [1]' % url
            # try cached version / history-linked-uri


class cfPlot():
    def plot_index(self, data, name='Index',
                   nb=True, datarange=None,
                   xticks=10, xticks_fontsize=10,
                   dateformat=False, figsize=(10, 8),
                   xmargin=True, ymargin=True,
                   legend=True, smoother=None,
                   output=None, dpi=300,
                   grid=True, xlabel='Year',
                   ylabel='', title='',
                   win_size=10, win_type='boxcar',
                   center=False, std=0.1,
                   beta=0.1, power=1, width=1,
                   min_periods=None, freq=None,
                   scategory=None, frac=1. / 3, it=3, figsave=None):
        """
        Function to plot the Climate Forcing indicator for the ESR 2013, it follow graphic guidlines from the past ESR
        adding functionalities like :
        several kind of smoothline with different
        @param data: pandas dataframe - input data
        @param name: string - name used as dataframe index
        @param nb: bolean if True the function is optimized to render the png inside a notebook
        @param datarange: list of 2 integer for mak min year
        @param xticks: integer xtick spacing default=10
        @param xticks_fontsize: integer xticks fontsize default=10
        @param dateformat: boolean if True set the xticks labels in date format
        @param figsize: tuple figure size default (10, 8)
        @param xmargin: bolean default True
        @param ymargin: bolean default True
        @param legend: bolean default True
        @param smoother: tuple (f,i)
        @param output: directory where to save output default None
        @param dpi: integer
        @param grid: bolean default True
        @param xlabel: string default 'Year'
        @param ylabel: string default ''
        @param title: string default ''
        @param win_size: integer default 10
        @param win_type: string default 'boxcar'
        @param center: bolean default False
        @param std: float default 0.1
        @param beta: float default 0.1
        @param power: integer default 1
        @param width: integer default 1
        @param min_periods: None
        @param freq: None
        @param scategory: string default 'rolling'
        @param frac: float default 0.6666666666666666 Between 0 and 1. The fraction of the data used when estimating each y-value.,
        @param it: integer default 3 The number of residual-based reweightings to perform.

        """
        try:
            assert type(data) == pd.core.frame.DataFrame
            #x = data.index.year
            #y = data.values
            if datarange:
            #if datarange != None :
                mind = np.datetime64(str(datarange[0]))
                maxd = np.datetime64(str(datarange[1]))
                newdata = data.ix[mind:maxd]
                x = newdata.index.year
                y = newdata.values
            else:
                x = data.index.year
                y = data.values
            x_p = x[np.where(y >= 0)[0]]
            y_p = y[np.where(y >= 0)[0]]
            x_n = x[np.where(y < 0)[0]]
            y_n = y[np.where(y < 0)[0]]
            fig = plt.figure(figsize=figsize)
            ax1 = fig.add_subplot(111)
            ax1.bar(x_n, y_n, 0.8, facecolor='b', label=name + ' < 0')
            ax1.bar(x_p, y_p, 0.8, facecolor='r', label=name + ' > 0')
            ax1.grid(grid)
            if ylabel != '':
                ax1.set_ylabel(ylabel)
            else:
                ax1.set_ylabel(name)
            if xlabel != '':
                ax1.set_xlabel(xlabel)
            else:
                ax1.set_xlabel(xlabel)
            if title == '':
                ax1.set_title(name)
            else:
                ax1.set_title(title)
            ax1.axhline(0, color='black', lw=1.5)
            if xmargin:
                ax1.set_xmargin(0.1)
            if ymargin:
                ax1.set_xmargin(0.1)
            if legend:
                ax1.legend()
            if not figsave:
                figsave = name + '.png'
            if scategory == 'rolling':
                newy = self.rolling_smoother(data, stype=smoother, win_size=win_size, win_type=win_type, center=center, std=std,
                                        beta=beta, power=power, width=width)
                ax1.plot(newy.index.year, newy.values, lw=3, color='g')
            if scategory == 'expanding':
                newy = self.expanding_smoother(data, stype=smoother, min_periods=min_periods, freq=freq)
                ax1.plot(newy.index.year, newy.values, lw=3, color='g')
            if scategory == 'lowess':
                x = np.array(range(0, len(data.index.values))).T
                newy = pd.Series(lowess(data.values.flatten(), x, frac=frac, it=it).T[1], index=data.index)
                ax1.plot(newy.index.year, newy, lw=3, color='g')
                ## interp 1D attempt
                xx = np.linspace(min(data.index.year), max(data.index.year), len(newy))
                f = interp1d(xx, newy)
                xnew = np.linspace(min(data.index.year), max(data.index.year), len(newy) * 4)
                f2 = interp1d(xx, newy, kind='cubic')
                #xnew = np.linspace(min(data.index.values), max(data.index.values), len(newy)*2)
                ax1.plot(xx, newy, 'o', xnew, f(xnew), '-', xnew, f2(xnew), '--')
                ##
            if scategory == 'ewma':
                print 'todo'
            plt.xticks(data.index.year[::xticks].astype('int'), data.index.year[::xticks].astype('int'),
                       fontsize=xticks_fontsize)
            plt.autoscale(enable=True, axis='both', tight=True)
            if dateformat:
                fig.autofmt_xdate(bottom=0.2, rotation=75, ha='right')
            if output:
                eu.ensure_dir(output)
                ffigsave = os.path.join(output, figsave)
                plt.savefig(ffigsave, dpi=dpi)
                print 'graph saved in: ', ffigsave
                if scategory:
                    smoutput = name + '_' + scategory + '.csv'
                    if smoother:
                        smoutput = name + '_' + scategory + '_' + smoother + '.csv'
                    smoutput = os.path.join(output, smoutput)
                    if scategory == 'lowess':
                        #print type(data)
                        newdataframe = data.copy(deep=True)
                        newdataframe['smooth'] = pd.Series(newy, index=data.index)
                        newdataframe.to_csv(smoutput, sep=',', header=True, index=True, index_label='Year')
                    else:
                        newy.to_csv(smoutput, sep=',', header=True, index=True, index_label='Year')
                    print name, 'smothed data saved in : ', smoutput
            if nb:
                fig.subplots_adjust(left=-1.0)
                fig.subplots_adjust(right=1.0)
            plt.show()
        except AssertionError:
            if type(data) != pd.core.frame.DataFrame:
                print 'input data not campatible, it has to be of type : pandas.core.frame.DataFrame'
            print 'data not loaded correctly'


    def rolling_smoother(self, data, stype='rolling_mean', win_size=10, win_type='boxcar', center=False, std=0.1, beta=0.1,
                         power=1, width=1):
        """
        Perform a espanding smooting on the data for a complete help refer to http://pandas.pydata.org/pandas-docs/dev/computation.html
        @param data:
        @param stype:
        @param win_size:
        @param win_type:
        @param center:
        @param std:
        @param beta:
        @param power:
        @param width:
        smoothing types:
            ROLLING :
                rolling_count	Number of non-null observations
                rolling_sum	Sum of values
                rolling_mean	Mean of values
                rolling_median	Arithmetic median of values
                rolling_min	Minimum
                rolling_max	Maximum
                rolling_std	Unbiased standard deviation
                rolling_var	Unbiased variance
                rolling_skew	Unbiased skewness (3rd moment)
                rolling_kurt	Unbiased kurtosis (4th moment)
                rolling_window	Moving window function
                    window types:
                        boxcar
                        triang
                        blackman
                        hamming
                        bartlett
                        parzen
                        bohman
                        blackmanharris
                        nuttall
                        barthann
                        kaiser (needs beta)
                        gaussian (needs std)
                        general_gaussian (needs power, width)
                        slepian (needs width)
        """
        if stype == 'count':
            newy = pd.rolling_count(data, win_size)
        if stype == 'sum':
            newy = pd.rolling_sum(data, win_size)
        if stype == 'mean':
            newy = pd.rolling_mean(data, win_size)
        if stype == 'median':
            newy = pd.rolling_median(data, win_size)
        if stype == 'min':
            newy = pd.rolling_min(data, win_size)
        if stype == 'max':
            newy = pd.rolling_max(data, win_size)
        if stype == 'std':
            newy = pd.rolling_std(data, win_size)
        if stype == 'var':
            newy = pd.rolling_var(data, win_size)
        if stype == 'skew':
            newy = pd.rolling_skew(data, win_size)
        if stype == 'kurt':
            newy = pd.rolling_kurt(data, win_size)
        if stype == 'window':
            if win_type == 'kaiser':
                newy = pd.rolling_window(data, win_size, win_type, center=center, beta=beta)
            if win_type == 'gaussian':
                newy = pd.rolling_window(data, win_size, win_type, center=center, std=std)
            if win_type == 'general_gaussian':
                newy = pd.rolling_window(data, win_size, win_type, center=center, power=power, width=width)
            else:
                newy = pd.rolling_window(data, win_size, win_type, center=center)
        return newy


    def expanding_smoother(self, data, stype='rolling_mean', min_periods=None, freq=None):
        """
        Perform a expanding smooting on the data for a complete help refer to http://pandas.pydata.org/pandas-docs/dev/computation.html
        @param data: pandas dataframe input data
        @param stype: soothing type
        @param min_periods: periods
        @param freq: frequence
        smoothing types:
        expanding_count	Number of non-null observations
        expanding_sum	Sum of values
        expanding_mean	Mean of values
        expanding_median	Arithmetic median of values
        expanding_min	Minimum
        expanding_max	Maximum
        expandingg_std	Unbiased standard deviation
        expanding_var	Unbiased variance
        expanding_skew	Unbiased skewness (3rd moment)
        expanding_kurt	Unbiased kurtosis (4th moment)
        """
        if stype == 'count':
            newy = pd.expanding_count(data, min_periods=min_periods, freq=freq)
        if stype == 'sum':
            newy = pd.expanding_sum(data, min_periods=min_periods, freq=freq)
        if stype == 'mean':
            newy = pd.expanding_mean(data, min_periods=min_periods, freq=freq)
        if stype == 'median':
            newy = pd.expanding_median(data, min_periods=min_periods, freq=freq)
        if stype == 'min':
            newy = pd.expanding_min(data, min_periods=min_periods, freq=freq)
        if stype == 'max':
            newy = pd.expanding_max(data, min_periods=min_periods, freq=freq)
        if stype == 'std':
            newy = pd.expanding_std(data, min_periods=min_periods, freq=freq)
        if stype == 'var':
            newy = pd.expanding_var(data, min_periods=min_periods, freq=freq)
        if stype == 'skew':
            newy = pd.expanding_skew(data, min_periods=min_periods, freq=freq)
        if stype == 'kurt':
            newy = pd.expanding_kurt(data, min_periods=min_periods, freq=freq)
        return newy



class cfPrint():
    def cftemplate(self,ID, pdfdict):
        textfile = pdfdict['textfile']
        cf = pdfdict['cf']
        naotxt = pdfdict['naotxt']
        naofigfile = pdfdict['naofigfile']
        naodatalink = pdfdict['naodatalink']
        nbviewerlink = pdfdict['nbviewerlink']
        amotxt = pdfdict['amotxt']
        amofigfile = pdfdict['amofigfile']
        amodatalink = pdfdict['amodatalink']
        nbviewerlink = pdfdict['nbviewerlink']
        template = """\documentclass{article}
        \usepackage{multicol}
        \usepackage[english]{babel}
        \usepackage{blindtext}
        \usepackage[pdftex]{graphicx}
        \usepackage{graphicx}
        \usepackage{wrapfig}
        \usepackage{hyperref}
        \usepackage{fancyvrb}
        \usepackage[utf8]{inputenc}
        \\begin{document}
        \\begin{twocolumn}
        \section{Climate Forcing}
        \input{%s}
        \subsection{North Atlantic Oscillation Index}
        \inputencoding{utf8}
        \input{%s}
        \\begin{figure}[h]
        {\includegraphics[width=60mm]{%s}}
        \caption{North Atlantic Oscillation - \href{%s}{data} -
        \href{%s}{code}.}
        \end{figure}
        \subsection{Atlantic Multidecadal Oscillation}
        \inputencoding{utf8}
        \input{%s}
        \\begin{figure}[h]
        {\includegraphics[width=60mm]{%s}}
        \caption{Atlantic Multidecadal Oscillation - \href{%s}{data} - \href{%s}{code}.}
        \end{figure}
        \end{twocolumn}
        \end{document}"""
        linestring = template % (
            cf, naotxt, naofigfile, naodatalink, nbviewerlink, amotxt, amofigfile, amodatalink, nbviewerlink)
        newfile = open(os.path.join(ID, 'climate_forcing.tex'), 'w')
        print textfile, ID
        texoutput = os.path.join(ID, textfile)
        newfile = open(texoutput, 'w')
        newfile.write(linestring)
        newfile.close()
        print texoutput

    def openDocument(col='twocolumn'):
        doc = """\documentclass{article}
        \usepackage{multicol}
        \usepackage[english]{babel}
        \usepackage{blindtext}
        \usepackage[pdftex]{graphicx}
        \usepackage{graphicx}
        \usepackage{wrapfig}
        \usepackage{hyperref}
        \usepackage{fancyvrb}
        \usepackage[utf8]{inputenc}
        \\begin{document}
        \\begin{%s}
        """ % col
        return doc

    def closeDocument(col='twocolumn'):
        doc = """\end{%s}
        \end{document}
        """ % (col)
        return doc


    def addSection(name, data, fig=''):
        doc = """\section{%s}
        \input{%s}
        %s
        """ % (name, data, fig)
        return doc

    def addSubSection(name, data, fig=''):
        doc = """\subsection{%s}
        \input{%s}
        %s
        """ % (name, data, fig)
        return doc


    def addFigure(img, name, metadata):
        doc ="""\\begin{figure}[h]
        {\includegraphics[width=60mm]{%s}}
        \caption{%s - \href{%s}{metadata}.}
        \end{figure}
        """ % (img, name, metadata)
        return doc




class openLayers():
    def df2feature(df, lat='LATITUDE',lon='LONGITUDE',prec=5):
        features = []
        try :
            for i, v in enumerate(df):
                properties = {}
                for j, k in enumerate(df.columns):
                    if df.columns[j] in [lat, lon]:
                        properties[df.columns[j]] = str(df[df.columns[j]][i])[:prec]
                    elif df[df.columns[j]][i] > 0:
                        properties[df.columns[j]] = str(df[df.columns[j]][i])[:prec]  #  df[df.columns[j]][i]
                my_feature = Feature(
                             geometry=Point((df.values[i][4], df.values[i][3])),
                             properties=properties
                              )
                features.append(my_feature)
            return features
        except:
            print 'done'
        #return features

    def addWMS(name, getcapabilities, layername, title):
        wms = """
            var %s = new OpenLayers.Layer.WMS( "%s",
         "%s",
            {layers: '%s',
            transparent: true,
            srs: 'EPSG:4326',
            isBaseLayer: false,
            visibility: false
            }

        );
        map.addLayer(%s);
        %s.setIsBaseLayer(false);
        """ % (name, title, getcapabilities, layername, name, name)
        return wms


    def df2feature(df, lat='LATITUDE',lon='LONGITUDE',prec=5):
        features = []
        try :
            for i, v in enumerate(df):
                properties = {}
                for j, k in enumerate(df.columns):
                    if df.columns[j] in [lat, lon]:
                        properties[df.columns[j]] = str(df[df.columns[j]][i])[:prec]
                    elif df[df.columns[j]][i] > 0:
                        properties[df.columns[j]] = str(df[df.columns[j]][i])[:prec]  #  df[df.columns[j]][i]
                my_feature = Feature(
                             geometry=Point((df.values[i][4], df.values[i][3])),
                             properties=properties
                              )
                features.append(my_feature)
        except:
            print 'done'
        return features

    def makeSingleStyle(vectorlist):
        fstylish = ''
        for j, k in enumerate(vectorlist):
            stylish = ''
            if vectorlist[j]['type'] == 'point':
                style = '''
                var %s_template = {
                    pointRadius: %s,
                    strokeColor: "rgb%s",
                    strokeOpacity: %s,
                    fillColor: "rgb%s",
                    fillOpacity: %s
                    }
                var %s_style = new OpenLayers.Style(%s_template)
                ''' % (vectorlist[j]['name'], vectorlist[j]['style']['singlestyle']['pointRadius'], vectorlist[j]['style']['singlestyle']['strokeColor'], vectorlist[j]['style']['singlestyle']['strokeOpacity'], vectorlist[j]['style']['singlestyle']['fillColor'], vectorlist[j]['style']['singlestyle']['fillOpacity'], vectorlist[j]['name'], vectorlist[j]['name'])
            fstylish += style
        return fstylish




    def makeStyle3(vectorlist):

        fstylish = ''
        for j, k in enumerate(vectorlist):
            stylish = ''

            openstyle = '''
            var %s_style = new OpenLayers.Style(
                OpenLayers.Util.applyDefaults({
                    strokeColor: "${getStrokeColor}",
                    strokeOpacity: "${getOpacity}",
                    strokeWidth: "${getLineWidth}",
                    fillColor: "${getFillColor}",
                    fillOpacity: "${getOpacity}"
                }, OpenLayers.Feature.Vector.style["default"]), {
                    context: {
                    ''' % vectorlist[j]['name']

            OpenOpacity = '''
                        getOpacity: function(feature) {
                        '''

            #print vectorlist[j]['style']
            OpacityData = ''
            for i,v in enumerate(vectorlist[j]['style'].keys()):
                if i == 0:
                    OpacityData += '''
                            if (feature.attributes.LABEL=="%s"){
                                element=%s;
                            }
                            ''' % (v,vectorlist[j]['style'][v]['Opacity'])
                else:
                    OpacityData += '''
                            else if (feature.attributes.LABEL=="%s"){
                                element=%s;
                            }
                            ''' % (v,vectorlist[j]['style'][v]['Opacity'])

            CloseOpacity = '''
                            else {
                                element="NULL";
                            }
                            return element;
                        },
                        '''

            OpenStrokeColor = '''
                        getStrokeColor: function(feature) {
                        '''

            StrokeColorData = ''
            for i,v in enumerate(vectorlist[j]['style'].keys()):
                if i == 0:
                    StrokeColorData += '''
                            if (feature.attributes.LABEL=="%s"){
                                element="rgb%s";
                            }
                            ''' % (v,vectorlist[j]['style'][v]['StrokeColor'])
                else:
                    StrokeColorData += '''
                            else if (feature.attributes.LABEL=="%s"){
                                element="rgb%s";
                            }
                            ''' % (v,vectorlist[j]['style'][v]['StrokeColor'])

            CloseStrokeColor = '''
                            else {
                                element="NULL";
                            }
                            return element;
                        },
                        '''

            OpenFillColor = '''
                        getFillColor: function(feature) {
                        '''

            FillColorData = ''
            for i,v in enumerate(vectorlist[j]['style'].keys()):
                if i == 0:
                    FillColorData += '''
                            if (feature.attributes.LABEL=="%s"){
                                element="rgb%s";
                            }
                            ''' % (v,vectorlist[j]['style'][v]['FillColor'])
                else:
                    FillColorData += '''
                            else if (feature.attributes.LABEL=="%s"){
                                element="rgb%s";
                            }
                            ''' % (v,vectorlist[j]['style'][v]['FillColor'])

            CloseFillColor = '''
                            else {
                                element="NULL";
                            }
                            return element;
                        },
                        '''

            OpenLineWidth = '''
                        getLineWidth: function(feature) {
                        '''

            LineWidthData = ''
            for i,v in enumerate(vectorlist[j]['style'].keys()):
                if i == 0:
                    LineWidthData += '''
                            if (feature.attributes.LABEL=="%s"){
                                element=%s;
                            }
                            ''' % (v,vectorlist[j]['style'][v]['LineWidth'])
                else:
                    LineWidthData += '''
                            else if (feature.attributes.LABEL=="%s"){
                                element=%s;
                            }
                            ''' % (v,vectorlist[j]['style'][v]['LineWidth'])

            CloseLineWidth = '''
                            else {
                                element="NULL";
                            }
                            return element;
                        },
                        '''

            CloseStyle = '''
                    }
                }
            );'''


            stylish += openstyle

            stylish += OpenOpacity
            stylish += OpacityData
            stylish += CloseOpacity

            stylish += OpenStrokeColor
            stylish += StrokeColorData
            stylish += CloseStrokeColor

            stylish += OpenFillColor
            stylish += FillColorData
            stylish += CloseFillColor

            stylish += OpenLineWidth
            stylish += LineWidthData
            stylish += CloseLineWidth

            stylish += CloseStyle
            fstylish += stylish
        return fstylish

    def makeQuery3(vectorlist):
        # fields is a list of attributes,
        # it should be derived directly form an input vector datasource
        # like ogrinfo
        querytemplate = ''
        for i, v in enumerate(vectorlist):
            query = """
            function onPopupClose%s(evt) {
                selectControl.unselect(selectedFeature);
            }
            function onFeatureSelect%s(feature){
                selectedFeature = feature;
            """ %  (vectorlist[i]['name'], vectorlist[i]['name'])
            tablevector = '''tablevector="<html><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'><body><table>'''
            for j in vectorlist[i]['fields']:
                tablevector += '''<tr><td><b>%s:</b></td><td><i>"+feature.attributes["%s"]+"</i></td></tr>''' % (j, j)
            tablevector += '''</table></body></html>";'''
            query += tablevector
            query += '''
                popup = new OpenLayers.Popup.FramedCloud("chicken",
                    feature.geometry.getBounds().getCenterLonLat(),
                    new OpenLayers.Size(1000,500),
                    tablevector,
                    null,
                    true,
                    onPopupClose%s
                );
                feature.popup = popup;
                map.addPopup(popup);
            }
            function onFeatureUnselect%s(feature) {
                map.removePopup(feature.popup);
                feature.popup.destroy();
                feature.popup = null;
            }
            var %s = new OpenLayers.Layer.Vector("%s", {
            styleMap: %s_style,
            projection: "EPSG:4326",
            strategies: [new OpenLayers.Strategy.Fixed()],
            protocol: new OpenLayers.Protocol.HTTP({
            url: "%s",
            format: new OpenLayers.Format.GeoJSON()
            })
            });
            map.addLayer(%s);
            '''  % (vectorlist[i]['name'], vectorlist[i]['name'], vectorlist[i]['name'], vectorlist[i]['name'], vectorlist[i]['name'], vectorlist[i]['url'], vectorlist[i]['name'])
            querytemplate += query
        return querytemplate


    def control3(vectorlist):
        layerlist = []
        s = ''
        for i , v in enumerate(vectorlist):
            s+=str(vectorlist[i]['name'])+','
        query = """
    selectControl = new OpenLayers.Control.SelectFeature(
                [%s ],
                {
                    clickout: true, toggle: false,
                    multiple: false, hover: false,
                    toggleKey: "ctrlKey", // ctrl key removes from selection
                    multipleKey: "shiftKey" // shift key adds to selection
                }
            );""" % s #vectorlist[i]['name']
        query +="""
            map.addControl(selectControl);
            selectControl.activate();
            """
        for i, v in enumerate(vectorlist):
            query +="""
            %s.events.on({
                "featureselected": function(e) {
                    onFeatureSelect%s(e.feature);
                },
                "featureunselected": function(e) {
                    onFeatureUnselect%s(e.feature);
                }
            });""" % (vectorlist[i]['name'], vectorlist[i]['name'], vectorlist[i]['name'])

        return query