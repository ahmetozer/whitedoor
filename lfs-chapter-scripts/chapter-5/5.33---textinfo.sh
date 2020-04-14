current_dir=$(pwd)
cd $LFS/sources

tar -xvf texinfo-6.7.tar.xz

cd texinfo-6.7

./configure --prefix=/tools
make

make check

make install


cd $current_dir
