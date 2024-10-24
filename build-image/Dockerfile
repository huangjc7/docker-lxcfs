FROM centos:7 as build

RUN rm -f /etc/yum.repos.d/* && \
    curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo && \
    curl -o /etc/yum.repos.d/epel-7.repo https://mirrors.aliyun.com/repo/epel-7.repo

RUN yum update -y
RUN yum install -y \
    fuse-devel \
    fuse \
    pam-devel \
    wget \
    gcc \
    automake \
    autoconf \
    libtool \
    make \
    cmake \
    pkgconfig \
    meson \
    ninja-build \
    *python3-jinja2* \
    *jinja2* \
    systemd-devel \
    help2man

ENV LXCFS_VERSION 6.0.1
RUN wget https://linuxcontainers.org/downloads/lxcfs/lxcfs-$LXCFS_VERSION.tar.gz && \
	mkdir -p /lxcfs /usr/local/lib/x86_64-linux-gnu/lxcfs/ && tar xzvf lxcfs-$LXCFS_VERSION.tar.gz -C /lxcfs  --strip-components=1 && \
	cd /lxcfs &&  make all

FROM centos:7
STOPSIGNAL SIGINT

COPY --from=build /lxcfs /lxcfs
COPY --from=build /usr/lib64/libfuse.so.2.9.2 /lxcfs/libfuse.so.2.9.2
COPY --from=build /usr/lib64/libulockmgr.so.1.0.1 /lxcfs/libulockmgr.so.1.0.1

COPY start.sh /
RUN rm -f /etc/yum.repos.d/* && \
    curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo && \
    curl -o /etc/yum.repos.d/epel-7.repo https://mirrors.aliyun.com/repo/epel-7.repo
RUN yum -y update && yum -y install fuse && chmod +x /start.sh
CMD ["/start.sh"]