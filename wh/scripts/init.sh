echo "Welcome to White Door"

mkdir -p /wh/os

STARTUP_FILES="/wh/scripts/startup/*"
for f in $STARTUP_FILES; do
  echo "Startup file: $f"
  source "$f"
done

if [ -f "/wh/layers/os/system.squashfs" ]; then
  mkdir -p /tmp/upper/os /tmp/work/os /mnt/os
  mount -o loop -t squashfs /wh/layers/os/system.squashfs /mnt/os
  mount -t overlay overlay -o lowerdir=/mnt/os,upperdir=/tmp/upper/os,workdir=/tmp/work/os /wh/os
  mkdir -p /wh/os/dev /wh/os/proc /wh/os/initroot /wh/os/sys /wh/os/home /wh/os/sys/fs/cgroup
else
  echo "Ramroot system file not found, script will copy existing system into ram"
  mount -t tmpfs none /wh/os
  mkdir -p /wh/os/dev /wh/os/proc /wh/os/initroot /wh/os/sys /wh/os/home /wh/os/sys/fs/cgroup
  cp -a /{bin,etc,mnt,sbin,lib,usr,var,dev,tmp,root,home} /wh/os
fi

mount -t tmpfs none /tmp/
mkdir -p /tmp/upper/lib/modules/ /tmp/work/lib/modules/ /wh/os/lib/modules/
mount -t overlay overlay -o lowerdir=/lib/modules/,upperdir=/tmp/upper/lib/modules/,workdir=/tmp/work/lib/modules/ /wh/os/lib/modules/

FILES="/wh/layers/os/*.tar"
for f in $FILES; do
  echo "Processing $f file..."
  tar -xvf $f -C /wh/os
done

mount --rbind /dev /wh/os/dev
mount --rbind /proc /wh/os/proc
mount -t cgroup cgroup /sys/fs/cgroup
mount --rbind /sys /wh/os/sys/

pivot_root /wh/os /wh/os/initroot
echo "Root is switched"

if [ -f '/etc/rc.local' ]; then
  exec /etc/rc.local
fi

cat /wh/os/initroot/etc/resolv.conf >>/etc/resolv.conf
