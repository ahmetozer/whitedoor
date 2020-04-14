current_dir=$(pwd)
cd $LFS/sources


tar -xvf patch-2.7.6.tar.xz
cd patch-2.7.6



./configure --prefix=/tools


make

make check

make install

cd $current_dir
