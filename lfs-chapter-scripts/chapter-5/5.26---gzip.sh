current_dir=$(pwd)
cd $LFS/sources

tar -xvf gzip-1.10.tar.xz
cd gzip-1.10

./configure --prefix=/tools

make

make check

make install


cd $current_dir
