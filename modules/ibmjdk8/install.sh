#!/bin/sh

set -e

microdnf install gzip

echo "INSTALLER_UI=silent" > /tmp/response.properties \
  && echo "USER_INSTALL_DIR=/opt/ibm/java" >> /tmp/response.properties \
  && echo "LICENSE_ACCEPTED=TRUE" >> /tmp/response.properties \
  && mkdir -p /opt/ibm \
  && chmod +x /tmp/artifacts/ibm-java.bin \
  && /tmp/artifacts/ibm-java.bin -i silent -f /tmp/response.properties \
  && rm -f /tmp/response.properties \
  && rm -f /tmp/artifacts/ibm-java.bin

# Subsequent installation of maven needs gzip
# microdnf remove gzip

