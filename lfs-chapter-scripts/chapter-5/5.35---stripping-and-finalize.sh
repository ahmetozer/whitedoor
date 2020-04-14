current_dir=$(pwd)
cd $LFS/sources


strip --strip-debug /tools/lib/*
/usr/bin/strip --strip-unneeded /tools/{,s}bin/*

rm -rf /tools/{,share}/{info,man,doc}

find /tools/{lib,libexec} -name \*.la -delete

chown -R root:root $LFS/tools

cd $current_dir
