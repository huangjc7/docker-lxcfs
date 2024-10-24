#!/bin/bash
docker run -d \
  --pid=host \
  --privileged \
  --restart=always \
  -v /sys/fs/cgroup:/sys/fs/cgroup \
  -v /usr/local:/usr/local \
  -v /usr/lib64:/usr/lib64 \
  -v /var/lib/lxcfs:/var/lib/lxcfs \
  jcregistry/lxcfs:v6.0.1