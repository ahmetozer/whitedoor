cd /sources


tar -xvf file-5.38.tar.gz
cd file-5.38/

./configure --prefix=/usr

make

make check

make install
