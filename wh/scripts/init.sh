mkdir -p /wh/os
mount -t tmpfs none /wh/os
mkdir -p /wh/os/dev /wh/os/proc /wh/os/initroot /wh/os/sys /wh/os/home

echo "Welcome to White Door"

STARTUP_FILES="/wh/scripts/startup/*"
for f in $STARTUP_FILES; do
  echo "Startup file: $f"
  source "$f"
done

mount -t tmpfs none /tmp/

mkdir -p /tmp/upper/lib/modules/ /tmp/work/lib/modules/  /wh/os/lib/modules/
mount -t overlay overlay -o lowerdir=/lib/modules/,upperdir=/tmp/upper/lib/modules/,workdir=/tmp/work/lib/modules/ /wh/os/lib/modules/


if [ ! -f "/wh/layers/os/system.tar" ]; then
  echo "Ramroot system file not found, script will copy existing system into ram"
  cp -a /{bin,etc,mnt,sbin,lib,usr,var,dev,tmp,root,home} /wh/os
fi



FILES="/wh/layers/os/*"
for f in $FILES; do
  echo "Processing $f file..."
  tar -xvf $f -C /wh/os
done

mount --rbind /dev /wh/os/dev
mount --rbind /proc /wh/os/proc
mount -t proc none /wh/os/proc
mount -t sysfs /wh/os/sys

pivot_root /wh/os /wh/os/initroot
echo "Root is switched"

if [ -f '/etc/initrc' ]; then
  exec /etc/initrc
fi

cat /wh/os/initroot/etc/resolv.conf >> /etc/resolv.conf
