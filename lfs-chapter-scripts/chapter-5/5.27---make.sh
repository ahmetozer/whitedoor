local current_dir=$(pwd)
cd $LFS/sources


./configure --prefix=/tools --without-guile

make

make check

make install


cd $current_dir
