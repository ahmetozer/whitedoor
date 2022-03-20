mkdir -p /boot
mount /dev/mmcblk0p1 /boot
cp -a /boot/ /

mount -t proc /proc /os/proc/
mount --rbind /sys /os/sys/
mount --rbind /dev /os/dev/
mount -t cgroup cgroup /os/sys/fs/cgroup

cp /etc/resolv.conf /os/etc/resolv.conf

chroot /os/ ash