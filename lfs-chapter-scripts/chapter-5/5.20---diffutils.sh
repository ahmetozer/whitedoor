current_dir=$(pwd)
cd $LFS/sources

tar -xvf diffutils-3.7.tar.xz

cd diffutils-3.7

./configure --prefix=/tools

make

make check

make install


cd $current_dir
