local current_dir=$(pwd)
cd $LFS/sources

tar -xvf binutils-2.34.tar.xz
cd binutils-2.34

CC=$LFS_TGT-gcc                \
AR=$LFS_TGT-ar                 \
RANLIB=$LFS_TGT-ranlib         \
../configure                   \
    --prefix=/tools            \
    --disable-nls              \
    --disable-werror           \
    --with-lib-path=/tools/lib \
    --with-sysroot


make -j$(nproc)
make install

cd $LFS/sources

cd $current_dir
