#!/bin/sh

set -e

    tar -C /usr/local -zxf /tmp/artifacts/maven.tar.gz \
      && ln -sf /usr/local/apache-maven-3.5.4/bin/mvn /usr/local/bin/mvn 

SCRIPT_DIR=$(dirname $0)
ARTIFACTS_DIR=${SCRIPT_DIR}/artifacts
pushd ${ARTIFACTS_DIR}

mkdir  -p /home/default/.m2/repository
chown -R 1001 /home/default/.m2
chmod -R ug+rwX /home/default/.m2

ls
cp settings.xml /home/default/.m2
popd

