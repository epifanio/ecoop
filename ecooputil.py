#!/usr/bin/python

import os
import sys
from zipfile import ZipFile, ZIP_DEFLATED
from contextlib import closing
import paramiko
import qrcode
from IPython.core.display import HTML, Image
from IPython.display import display, Javascript
import envoy
from datetime import datetime

class shareUtil():
    def zipdir(self, basedir, archivename, rm='no'):
        """
        utility function to zip a single file or a directory
        usage : zipdir(input, output)
        @param basedir: input file or directory
        @param archivename: output file.zip
        @param rm: [yes, no], remove source file (optional, default=no)
        """
        assert os.path.isdir(basedir)
        with closing(ZipFile(archivename, "w", ZIP_DEFLATED)) as z:
            for root, dirs, files in os.walk(basedir):
                #NOTE: ignore empty directories
                for fn in files:
                    #print fn
                    absfn = os.path.join(root, fn)
                    zfn = absfn[len(basedir) + len(os.sep):] #XXX: relative path
                    z.write(absfn, zfn)
        if rm != 'no':
            instruction = 'rm -rf %s' % basedir
            os.system(instruction)

    def uploadfile(self, username='epi', password='epi', hostname='localhost', port=22,
                   inputfile=None, outputfile=None, link=False, apacheroot='/var/www/', zip=False, qr=False):
        '''
        utility to upload file on remote server using sftp protocol
        usage : uploadfile(inputfile, outputfile)
        @rtype : str
        @param username: str - username on remote server
        @param password: str - password to access remote server
        @param hostname: str - hostname of remote server (default: localhost)
        @param port: port number on remote server (default: 22)
        @param inputfile: str - local path to the file to uploaded
        @param outputfile: remote path to the file to upload
        @param link: bolean [True, False] default False, print a link to download the file
                                     (remote path needs to be in a web available directory)
        @param apacheroot: path to apache root default to '/var/www/' required if link == True
        @param zip: bolean deafault False, zip the output
        @param qr: bolean deafault False, return qrcode as image
        @return: link to uploaded file if link=True or qr image if qr=True & link=True, none if link is set to false
        '''
        if zip:
            #print 'add zipfile'
            zipfile = str(inputfile + '.zip')
            self.zipdir(inputfile, zipfile)
            inputfile = zipfile
            #paramiko.util.log_to_file('/var/www/esr/paramiko.log')
        client = paramiko.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        client.connect(hostname, username=username, password=password)
        transport = paramiko.Transport((hostname, port))
        transport.connect(username=username, password=password)
        sftp = paramiko.SFTPClient.from_transport(transport)
        parts = outputfile.split('/')
        for n in range(2, len(parts)):
            path = '/'.join(parts[:n])
            #print 'Path:', path,
            sys.stdout.flush()
            try:
                s = sftp.stat(path)
                #print 'mode =', oct(s.st_mode)
            except IOError as e:
                #print e
                #print 'adding dir: ', path
                sftp.mkdir(path)
        try:
            sftp.put(remotepath=outputfile, localpath=inputfile)
            sftp.close()
            transport.close()
            print 'file uploaded'
            if qr:
                if link:
                    pass
                if not link:
                    print 'WORNING: qrcode not generated, set the option link to True'
            if link:
                filelink = outputfile.replace(apacheroot, '')
                link = 'http://' + os.path.normpath(hostname + '/' + filelink)
                raw_html = '<a href="%s" target="_blank">ESR results</a>' % link
                print 'results are now available for download at : ', link
                image = None
                if qr:
                    imagefile = parts[-1].split('.')[0] + '.jpeg'
                    qr = qrcode.QRCode(version=1, error_correction=qrcode.constants.ERROR_CORRECT_L, box_size=10, border=4)
                    qr.add_data(link)
                    qr.make(fit=True)
                    img = qr.make_image()
                    img.save(imagefile, "JPEG")
                    print 'alive'
                    image = Image(imagefile)
                    return image
                if not qr:
                    return HTML(raw_html)
        except IOError:
            print "Error: can\'t find file or read data check if input file exist and or remote location is writable"

    def gistit(self, filename, jist='/usr/local/bin/jist', type='notebook'):
        '''
        use the jist utility to paste a txt file on github as gist and return a link to it
        usage :  gistit(notebookfile)
        @param filename: str - path to the a text file or notebook file (.json)
        @param jist: str - path to the executable jist (default=/usr/local/bin/jist)
        @param type: str - notebook, text
        @return: return a link to gist if type=text, link to nbviewer if type=notebook
        '''
        try:
            with open(filename):
                link = None
                jist = self.which(jist)
                if jist:
                    try:
                        r = envoy.run('%s -p %s' % (jist, filename))
                        if type == 'notebook':
                            link = r.std_out.replace('\n', '').replace('https://gist.github.com',
                                                                       'http://nbviewer.ipython.org')
                        if type == 'text':
                            link = r.std_out.replace('\n', '')
                        return link
                    except:
                        print "can't generate gist, check if jist works bycommand line with: jist -p filename"
                if not jist:
                    print 'cannot find jist utility, check if it is in your path'
        except IOError:
            print 'input file %s not found' % filename

    def get_id(self, suffix, makedir=True):
        '''
        generate a directory based on the suffix and a time stamp
        output looks like : suffix_Thursday_26_September_2013_06_28_49_PM
        usage: getID(suffix)
        @param suffix: str - suffix for the directory to be generated,
        @return: str - directory name
        '''
        ID = suffix + '_' + str(datetime.now().utcnow().strftime("%A_%d_%B_%Y_%I_%M_%S_%p"))
        if makedir:
            self.ensure_dir(ID)
        print 'session data directory : ID', ID
        return ID

    def ensure_dir(self, dir):
        '''
        make a directory on the file system if it does not exist
        usage: ensure_dir(dir)
        @param dir: str - path to a directory existent on the local filesystem
        @return: None
        '''
        if not os.path.exists(dir):
            os.makedirs(dir)

    def save_notebook(self, ID, notebookname, web=None, notebookdir=None):
        """
        Save the notebook file as html and or as gist
        @param ID: directory name where to store the saved notebook
        @param notebookname: name of the notebook
        @param web:
        @param notebookdir:
        """
        if not notebookdir:
            notebookdir = os.getcwd()
        display(Javascript("IPython.notebook.save_notebook()"))
        notebookfile = os.path.join(notebookdir, notebookname)
        savedir = os.path.join(os.getcwd(), ID)
        command1 = 'cp %s %s' % (notebookfile, savedir)
        newnotebook = os.path.join(savedir, notebookname)
        command2 = 'ipython nbconvert %s' % newnotebook
        os.system(command1)
        os.system(command2)
        if web:
            try:
                self.gistit(notebookfile)
            except IOError:
                print "can't genrate a gist"

    def which(self, program):
        """
        Check if a program exist and return the full path
        @param program: executable name or path to executable
        @return: full path to executable
        """
        def is_exe(fpath):
            return os.path.isfile(fpath) and os.access(fpath, os.X_OK)
        fpath, fname = os.path.split(program)
        if fpath:
            if is_exe(program):
                return program
        else:
            for path in os.environ["PATH"].split(os.pathsep):
                path = path.strip('"')
                exe_file = os.path.join(path, program)
                if is_exe(exe_file):
                    return exe_file
        return None