current_dir=$(pwd)
cd $LFS/sources

tar -xvf dejagnu-1.6.2.tar.gz
cd dejagnu-1.6.2

./configure --prefix=/tools

make install

make check


cd $current_dir
