#!/bin/sh

set -e

SCRIPT_DIR=$(dirname $0)
ARTIFACTS_DIR=${SCRIPT_DIR}/artifacts

if [[ -z ${WLP_DIR} ]]; then 
    WLP_DIR=/opt/ol
fi

chown -R 1001 $WLP_DIR
chown -R 1001 $SCRIPT_DIR
chmod -R ug+rwX $SCRIPT_DIR
chmod ug+x ${ARTIFACTS_DIR}/usr/local/s2i/*

pushd ${ARTIFACTS_DIR}
cp -pr * /
popd


