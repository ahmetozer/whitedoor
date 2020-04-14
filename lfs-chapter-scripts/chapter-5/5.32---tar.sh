current_dir=$(pwd)
cd $LFS/sources

tar -xvf tar-1.32.tar.xz

cd tar-1.32

./configure --prefix=/tools
make

make check

make install


cd $current_dir
