current_dir=$(pwd)
cd $LFS/sources

tar -xvf glibc-2.31.tar.xz
cd glibc-2.31

mkdir -v build
cd       build


../configure                             \
      --prefix=/tools                    \
      --host=$LFS_TGT                    \
      --build=$(../scripts/config.guess) \
      --enable-kernel=3.2                \
      --with-headers=/tools/include

			make -j$(nproc)
			make install



cd $LFS/sources
rm -rf glibc-2.31

echo 'int main(){}' > dummy.c
$LFS_TGT-gcc dummy.c
readelf -l a.out | grep ': /tools'
rm -v dummy.c a.out


cd $current_dir
