#!/bin/bash
cd "$(dirname $0)"
cd "$(pwd -P)"
set -e

QUICK=no
if [ ! -z "$1" ]; then
  if [ "$1" == "-q" ]; then
    shift
    QUICK=yes
  fi
fi

docker build -t insideo/oracle-jdk-debian --force-rm=true --rm=true --pull docker-build-env
docker rm -f "insideo-oracle-jdk-debian-tmp" 2>/dev/null || true
docker run --name "insideo-oracle-jdk-debian-tmp" "insideo/oracle-jdk-debian" /bin/sh
rm -rf packages || true
mkdir -p packages
docker cp "insideo-oracle-jdk-debian-tmp:/packages" .
docker rm -f "insideo-oracle-jdk-debian-tmp" 2>/dev/null || true

if [ "${QUICK}" != "yes" ]; then
  docker rmi "insideo/oracle-jdk-debian"
else 
  exit 0
fi
