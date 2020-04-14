current_dir=$(pwd)
cd $LFS/sources

tar -xvf linux-5.5.3.tar.xz
cd linux-5.5.3

make mrproper

make headers
cp -rv usr/include/* /tools/include

cd $LFS/sources
rm -rf linux-5.5.3

cd $current_dir
