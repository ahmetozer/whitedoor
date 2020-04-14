current_dir=$(pwd)
cd $LFS/sources

tar -xvf file-5.38.tar.gz
cd file-5.38

./configure --prefix=/tools

make

make check

make install


cd $current_dir
