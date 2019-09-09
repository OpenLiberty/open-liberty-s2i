#!/bin/sh

set -e

microdnf install gzip

    tar -C /usr/local -zxf /tmp/artifacts/maven.tar.gz \
      && ln -sf /usr/local/apache-maven-3.5.4/bin/mvn /usr/local/bin/mvn 

microdnf remove gzip

mkdir  -p /home/default/.m2/repository
chown -R 1001 /home/default/.m2
chmod -R ug+rwX /home/default/.m2
