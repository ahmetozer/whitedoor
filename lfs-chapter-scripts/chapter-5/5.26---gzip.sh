local current_dir=$(pwd)
cd $LFS/sources


./configure --prefix=/tools

make

make check

make install


cd $current_dir
