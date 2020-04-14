current_dir=$(pwd)
cd $LFS/sources

tar -xvf sed-4.8.tar.xz
cd sed-4.8


./configure --prefix=/tools
make

make check

make install


cd $current_dir
