FROM centos:6
MAINTAINER "Patrizio Tufarolo" <patriziotufarolo@gmail.com>
ENV version="0.99.2"
RUN yum -y install epel-release yum-utils
RUN yum -y install gcc glibc zlib-devel gmp-devel bzip2-devel openssl-devel wget
RUN yum-builddep -y clamav-milter
RUN groupadd zimbra -g 500 && useradd --home /opt/zimbra -u 500 -g 500 zimbra
RUN mkdir /build
VOLUME /opt/zimbra
WORKDIR /
ADD /build.sh /
ENTRYPOINT "/build.sh" 
