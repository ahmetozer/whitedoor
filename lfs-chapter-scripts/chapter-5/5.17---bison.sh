current_dir=$(pwd)
cd $LFS/sources

tar -xvf bison-3.5.2.tar.xz
cd bison-3.5.2

./configure --prefix=/tools

make

make check

make install


cd $current_dir
