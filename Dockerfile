FROM ubuntu:22.10 AS snort3

MAINTAINER NopFault x90.lt

RUN apt update && apt install -yq \
build-essential  \
libpcap-dev \
libpcre3-dev \
libnet1-dev \
zlib1g-dev \
luajit \
hwloc \
libdnet-dev \
libdumbnet-dev \
bison \
flex \
liblzma-dev \
openssl \
libssl-dev \
pkg-config \
libhwloc-dev \
cmake \
cpputest \
libsqlite3-dev \
uuid-dev \
libcmocka-dev \
libnetfilter-queue-dev \
libmnl-dev \
autotools-dev \
libluajit-5.1-dev \
libunwind-dev \
git \
net-tools \
wget \
iputils-ping


RUN cd /tmp && git clone https://github.com/snort3/libdaq.git && \
cd libdaq && \
./bootstrap && \
./configure && \
make && \
make install


RUN cd /tmp && wget https://github.com/gperftools/gperftools/releases/download/gperftools-2.9.1/gperftools-2.9.1.tar.gz && \
tar xzf gperftools-2.9.1.tar.gz && \
cd gperftools-2.9.1/ && \
./configure && make && make install


RUN cd /tmp && git clone https://github.com/snort3/snort3.git && cd snort3 && \
./configure_cmake.sh --prefix=/usr/local --enable-tcmalloc && \
cd build && \
make && \
make install && \
ldconfig && \
ln -s /usr/local/bin/snort /usr/sbin/snort


WORKDIR /opt

ADD custom.rules /opt
ADD entrypoint.sh /opt
RUN chmod a+x /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]


