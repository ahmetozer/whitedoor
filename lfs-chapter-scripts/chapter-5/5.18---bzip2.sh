current_dir=$(pwd)
cd $LFS/sources

tar -xvf bzip2-1.0.8.tar.gz
cd bzip2-1.0.8

make -f Makefile-libbz2_so
make clean

make

make PREFIX=/tools install
cp -v bzip2-shared /tools/bin/bzip2
cp -av libbz2.so* /tools/lib
ln -sv libbz2.so.1.0 /tools/lib/libbz2.so

cd $current_dir
