yum -y install gcc gcc-c++ gcc-gfortran blas-devel lapack-devel zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel \
freetype-devel libpng-devel svn git \
libxml2-devel libcurl-devel libtiff-devel mesa-libGLU-devel mesa-libGLw-devel cairo-devel pcre-devel ImageMagick-devel \
ImageMagick-c++-devel gnuplot-latex gsl-devel gtk2-devel java-1.7.0-openjdk-devel fftw-devel rubygems ruby-devel  >> yuminstall_devlibs.log
yum -y groupinstall "Development tools" >> yuminstall_devtools.log
gem install jist jist >> yuminstall_gems.log

#
# evaluate possibility to install pandoc via repository, it is needed by IPython nbconver
#

