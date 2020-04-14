current_dir=$(pwd)
cd $LFS/sources


tar -xvf xz-5.2.4.tar.xz
cd xz-5.2.4

./configure --prefix=/tools
make

make check

make install


cd $current_dir
