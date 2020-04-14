current_dir=$(pwd)
cd $LFS/sources

tar -xvf make-4.3.tar.gz
cd make-4.3


./configure --prefix=/tools --without-guile

make

make check

make install


cd $current_dir
