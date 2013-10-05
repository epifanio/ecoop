#!/usr/bin/python
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
class cfData():
    def __init__(self):
        self.x = 'Hello'

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
    def makepdf(self, ID, cf='climate_forcing.txt', naotxt='nao.txt', amotxt='amo.txt', nbname='None', nbviewerlink=None,
                naodatalink=None, amodatalink=None, naofigfile='nao.png', amofigfile='amo.png', verbose=False):
        """
        generate a PDF from a latext template ( it is intended to be just an eaxmple to show how to use a latex
        template to generate a pdf dinamically embedding link to URI inside the document)
        example for the first section of the ESR.
        NOTE :
        the data and uri can easly point to an RDF description of this document
        (the document needs its own ontology stored on a triple store)
        @param ID:
        @param cf:
        @param naotxt:
        @param amotxt:
        @param nbname:
        @param nbviewerlink:
        @param naodatalink:
        @param amodatalink:
        @param naofigfile:
        @param amofigfile:
        """
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
        naofigfile = os.path.join(ID, naofigfile)
        amofigfile = os.path.join(ID, amofigfile)
        #if os.path.isfile(naofigfile) and os.path.isfile(amofigfile):
        cf = cf
        naotxt = naotxt
        amotxt = amotxt
        listafile = [naofigfile, amofigfile, cf, naotxt, amotxt]
        for i in listafile:
            try:
                with open(i):
                    pass
            except IOError:
                print 'file %s not found' % i
                print 'make PDF aborted'
                return
        linestring = template % (
            cf, naotxt, naofigfile, naodatalink[0], nbviewerlink, amotxt, amofigfile, amodatalink[0], nbviewerlink)
        newfile = open(os.path.join(ID, cf), 'w')
        newfile.write(linestring)
        newfile.close()
        instruction = 'pdflatex -output-directory=%s %s' % (ID, cf)
        r = envoy.run(instruction, timeout=12)
        if verbose:
            print r.std_out.strip()#.split('\n')
        instruction2 = 'rm -rf %s/climate_forcing.aux %s/climate_forcing.log %s/climate_forcing.out' % (ID, ID, ID)
        r = envoy.run(instruction2, timeout=12)
        if verbose:
            print r.std_out.strip()#.split('\n')