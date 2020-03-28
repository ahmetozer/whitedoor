cd /sources


tar -xvf bc-2.5.3.tar.gz
cd bc-2.5.3


PREFIX=/usr CC=gcc CFLAGS="-std=c99" ./configure.sh -G -O3


make

make test


make install
