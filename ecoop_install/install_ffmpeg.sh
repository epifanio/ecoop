#sudo yum -y install autoconf automake libass-dev libgpac-devel \
#libsdl1.2-devel libtheora-devel libtool libva-devel libvdpau-devel libvorbis-devel libx11-devel \
#libxext-dedevelv libxfixes-devel pkg-config texi2html zlib1g-devel yasm libmp3lame-devel nasm libvpx-devel

# No package libass-devel available.

#libassuan-devel

# No package libgpac-devel available.

#yum install glib2-devel
#yum install glibc-devel
#yum install gcc
#yum install glut

# No package libsdl1.2-devel available.

#yum install SDL-devel


# No package libva-devel available.

# No package libvdpau-devel available.
# No package libx11-devel available.
#  * Maybe you meant: libX11-devel
# No package libxext-dedevelv available.
# No package libxfixes-devel available.
#  * Maybe you meant: libXfixes-devel
# No package pkg-config available.
# No package zlib1g-devel available.
# No package yasm available.
# No package libmp3lame-devel available.










BUILD=epilib
PREFIX=/home/$USER/Envs/env1

TEMPBUILD=/home/$USER/$BUILD

mkdir -p $TEMPBUILD
mkdir -p $TEMPBUILD/tarball
mkdir -p $TEMPBUILD/src

cd $TEMPBUILD
export PATH=$PREFIX/bin:$PATH


git clone --depth 1 git://git.videolan.org/x264.git
cd x264
./configure --prefix=$PREFIX --enable-static
make
make install
make distclean


cd $TEMPBUILD
git clone --depth 1 git://git.code.sf.net/p/opencore-amr/fdk-aac
cd fdk-aac
autoreconf -fiv
./configure --prefix=$PREFIX --disable-shared
make
make install
make distclean

cd $TEMPBUILD
wget http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz
tar xzvf lame-3.99.5.tar.gz
cd lame-3.99.5
./configure --prefix=$PREFIX --enable-nasm --disable-shared
make
make install
make distclean


cd $TEMPBUILD
wget http://downloads.xiph.org/releases/opus/opus-1.0.3.tar.gz
tar xzvf opus-1.0.3.tar.gz
cd opus-1.0.3
./configure --prefix=$PREFIX --disable-shared
make
make install
make distclean

cd $TEMPBUILD
git clone --depth 1 http://git.chromium.org/webm/libvpx.git
cd libvpx
./configure --prefix=$PREFIX --disable-examples
make
make install
make clean

cd $TEMPBUILD
git clone --depth 1 git://source.ffmpeg.org/ffmpeg
cd ffmpeg
PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig
export PKG_CONFIG_PATH
./configure --prefix=$PREFIX \
  --extra-cflags="-I$PREFIX/include" --extra-ldflags="-L$PREFIX/lib" \
  --extra-libs="-ldl" --enable-gpl --enable-libass --enable-libfdk-aac \
  --enable-libmp3lame --enable-libopus --enable-libtheora --enable-libvorbis --enable-libvpx \
  --enable-libx264 --enable-nonfree --enable-x11grab
make
make install
make distclean
hash -r
