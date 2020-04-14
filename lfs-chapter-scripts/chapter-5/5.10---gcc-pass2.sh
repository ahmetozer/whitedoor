current_dir=$(pwd)
cd $LFS/sources

tar -xvf gcc-9.2.0.tar.xz
cd gcc-9.2.0

cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include-fixed/limits.h

	for file in gcc/config/{linux,i386/linux{,64}}.h
	do
	  cp -uv $file{,.orig}
	  sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
	      -e 's@/usr@/tools@g' $file.orig > $file
	  echo '
	#undef STANDARD_STARTFILE_PREFIX_1
	#undef STANDARD_STARTFILE_PREFIX_2
	#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
	#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
	  touch $file.orig
	done

	case $(uname -m) in
	  x86_64)
	    sed -e '/m64=/s/lib64/lib/' \
	        -i.orig gcc/config/i386/t-linux64
	  ;;
	esac

	tar -xf ../mpfr-4.0.2.tar.xz
	mv -v mpfr-4.0.2 mpfr
	tar -xf ../gmp-6.2.0.tar.xz
	mv -v gmp-6.2.0 gmp
	tar -xf ../mpc-1.1.0.tar.gz
	mv -v mpc-1.1.0 mpc

	sed -e '1161 s|^|//|' \
    -i libsanitizer/sanitizer_common/sanitizer_platform_limits_posix.cc

mkdir -v build
cd       build

make
make install

ln -sv gcc /tools/bin/cc

echo 'int main(){}' > dummy.c
cc dummy.c
readelf -l a.out | grep ': /tools'

rm -v dummy.c a.out


cd $LFS/sources

cd $current_dir
