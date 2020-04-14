current_dir=$(pwd)
cd $LFS/sources

tar -xvf gettext-0.20.1.tar.xz
cd gettext-0.20.1

./configure --disable-shared

make

cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /tools/bin


cd $current_dir
