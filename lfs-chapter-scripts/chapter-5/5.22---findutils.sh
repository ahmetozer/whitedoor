current_dir=$(pwd)
cd $LFS/sources

tar -xvf findutils-4.7.0.tar.xz
cd findutils-4.7.0

./configure --prefix=/tools

make

make check

make install


cd $current_dir
