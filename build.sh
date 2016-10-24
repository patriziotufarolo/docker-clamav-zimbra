#!/bin/bash
VERSION=${version}

cd /build
wget http://www.clamav.net/downloads/production/clamav-${version}.tar.gz -P /build
tar zxfv clamav-${version}.tar.gz

cd /build/clamav-${VERSION}
./configure \
    --prefix=/opt/zimbra/clamav-${VERSION} \
    --with-user=zimbra \
    --with-group=zimbra \
    --with-dbdir=/opt/zimbra/clamav-${VERSION}/db/
    --enable-milter

make
make check
make install

echo "Creating db's directory"
mkdir /opt/zimbra/clamav-${VERSION}/db/

echo "Chowning to zimbra"
chown -R zimbra:zimbra /opt/zimbra/clamav-${VERSION}

echo "Done!"
