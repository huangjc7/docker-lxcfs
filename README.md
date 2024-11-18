# LXCFS资源视图隔离相关文件
* lxcfs容器部署
```shell
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
```
* 业务容器使用方法
```shell
docker run -d \
  --cpus=1 --memory=2g \
  -v /var/lib/lxcfs/proc/cpuinfo:/proc/cpuinfo \
  -v /var/lib/lxcfs/proc/diskstats:/proc/diskstats \
  -v /var/lib/lxcfs/proc/meminfo:/proc/meminfo \
  -v /var/lib/lxcfs/proc/stat:/proc/stat \
  -v /var/lib/lxcfs/proc/swaps:/proc/swaps \
  -v /var/lib/lxcfs/proc/uptime:/proc/uptime \
  -v /var/lib/lxcfs/proc/loadavg:/proc/loadavg \
  -v /var/lib/lxcfs/sys/devices/system/cpu/online:/sys/devices/system/cpu/online \
  your_image_name
```