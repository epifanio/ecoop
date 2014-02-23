import os
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