current_dir=$(pwd)
cd $LFS/sources

tar -xvf gawk-5.0.1.tar.xz

cd gawk-5.0.1

./configure --prefix=/tools

make

make check

make install



cd $current_dir
