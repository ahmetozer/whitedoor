cd /sources

tar -xvf mpfr-4.0.2.tar.xz
cd mpfr-4.0.2

./configure --prefix=/usr        \
            --disable-static     \
            --enable-thread-safe \
            --docdir=/usr/share/doc/mpfr-4.0.2

make

make html

make check


make install

make install-html
