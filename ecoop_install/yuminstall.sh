yum -y install gcc gcc-c++ gcc-gfortran blas-devel lapack-devel zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel \
freetype-devel libpng-devel svn git python-devel ruby texinfo texinfo-tex \
libxml2-devel libcurl-devel libtiff-devel mesa-libGLU-devel mesa-libGLw-devel cairo-devel pcre-devel ImageMagick-devel \
ImageMagick-c++-devel gnuplot-latex gsl-devel gtk2-devel java-1.7.0-openjdk-devel fftw-devel rubygems ruby-devel  >> yuminstall_devlibs.log
yum -y groupinstall "Development tools" >> yuminstall_devtools.log
gem install jist jist >> yuminstall_gems.log

#
# evaluate possibility to install pandoc via repository, it is needed by IPython nbconver
#
# wget http://geofemengineering.it//oracle-xe-11.2.0-1.0.x86_64.rpm
# wget http://www.haskell.org/ghc/dist/7.6.3/ghc-7.6.3-x86_64-unknown-linux.tar.bz2
# bzip2 ghc-7.6.3-x86_64-unknown-linux.tar.bz2
# tar -xvf ghc-7.6.3-x86_64-unknown-linux.tar



