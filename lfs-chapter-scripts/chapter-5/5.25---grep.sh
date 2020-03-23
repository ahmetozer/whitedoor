local current_dir=$(pwd)
cd $LFS/sources

tar -xvf


./configure --prefix=/tools


make

make check

make install

cd $current_dir
