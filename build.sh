#!/bin/bash
VERSION=${version}
cd /build/clamav-${VERSION}
./configure \
    --prefix=/opt/zimbra/clamav-${VERSION} \
    --with-user=zimbra \
    --with-group=zimbra \
    --enable-milter
make
make check
make install
