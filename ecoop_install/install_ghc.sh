
CURRENTDIR=${PWD}
BUILD=epilib
PREFIX=/home/$USER/Envs/env1

TEMPBUILD=/home/$USER/$BUILD
mkdir -p $TEMPBUILD
mkdir -p $TEMPBUILD/tarball
mkdir -p $TEMPBUILD/src

cd $TEMPBUILD
export PATH=$PREFIX/bin:$PATH

wget http://www.haskell.org/ghc/dist/7.6.3/ghc-7.6.3-x86_64-unknown-linux.tar.bz2
bunzip2 ghc-7.6.3-x86_64-unknown-linux.tar.bz2
tar -xvf ghc-7.6.3-x86_64-unknown-linux.tar
cd ghc-7.6.3
./configure --prefix=$PREFIX >> ../ghc_configure.log
make install >> ../ghc_install.log

make distclean > /dev/null 2>&1
cd $TEMPBUILD
mv ghc-7.6.3-x86_64-unknown-linux.tar.bz2 $TEMPBUILD/tarball
rm -rf ghc-7.6.3-x86_64-unknown-linux.tar
mv ghc-7.6.3 $TEMPBUILD/src

cd $TEMPBUILD


wget http://www.haskell.org/cabal/release/cabal-1.18.1.2/Cabal-1.18.1.2.tar.gz
tar -zxvf Cabal-1.18.1.2.tar.gz
cd Cabal-1.18.1.2
ghc --make Setup
./Setup configure --user --prefix=$PREFIX
./Setup build
./Setup install

cd ..
wget http://www.haskell.org/cabal/release/cabal-install-1.18.0.2/cabal-install-1.18.0.2.tar.gz
tar -zxvf cabal-install-1.18.0.2.tar.gz
cd cabal-install-1.18.0.2
./bootstrap.sh
#ln -s /home/$USER/.cabal/bin/cabal $PREFIX/bin/
cabal update
cabal install alex
cabal install happy
cabal install pandoc
cp -R /home/ecoop/.cabal/ /home/ecoop/Envs/env1/cabal
