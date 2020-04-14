current_dir=$(pwd)
cd $LFS/sources

tar -xvf grep-3.4.tar.xz
cd grep-3.4


./configure --prefix=/tools


make

make check

make install

cd $current_dir
