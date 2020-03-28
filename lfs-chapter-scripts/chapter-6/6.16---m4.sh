cd /sources

tar -xvf m4-1.4.18.tar.xz

cd m4-1.4.18

sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' lib/*.c
echo "#define _IO_IN_BACKUP 0x100" >> lib/stdio-impl.h


./configure --prefix=/usr

make

make check

make install
