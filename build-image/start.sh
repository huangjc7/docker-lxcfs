#!/bin/bash

# Cleanup
nsenter -t 1 -m umount /var/lib/lxcfs 2> /dev/null || true
nsenter -t 1 -m [ -L /etc/mtab ] || \
        sed -i "/^lxcfs \/var\/lib\/lxcfs fuse.lxcfs/d" /etc/mtab

# remove /var/lib/lxcfs
rm -rf /var/lib/lxcfs/*

# Prepare
mkdir -p /usr/local/lib64/lxcfs /var/lib/lxcfs


# Update lxcfs
cp -f /lxcfs/build/lxcfs /usr/local/bin/lxcfs
cp -f /lxcfs/build/liblxcfs.so /usr/local/lib64/lxcfs/liblxcfs.so

cp -f /lxcfs/libfuse.so.2.9.2 /usr/lib64/libfuse.so.2.9.2
cp -f /lxcfs/libulockmgr.so.1.0.1 /usr/lib64/libulockmgr.so.1.0.1

ln -s /usr/lib64/libfuse.so.2.9.2 /usr/lib64/libfuse.so.2
ln -s /usr/lib64/libulockmgr.so.1.0.1 /usr/lib64/libulockmgr.so.1

# Mount
exec nsenter -t 1 -m /usr/local/bin/lxcfs -l --enable-pidfd --enable-cfs /var/lib/lxcfs/
