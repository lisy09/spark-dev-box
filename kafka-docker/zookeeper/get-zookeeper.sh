#!/bin/sh -e

## Prerequisite: need curl & wget & jq & gpg installed; ZOOKEEPER_VERSION set

FILENAME="apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz"

url=$(curl --stderr /dev/null "https://www.apache.org/dyn/closer.cgi?path=/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/${FILENAME}&as_json=1" | jq -r '"\(.preferred)\(.path_info)"')
if [[ ! $(curl -s -f -I "${url}") ]]; then
    echo "Mirror does not have desired version, downloading direct from Apache"
    url="https://archive.apache.org/dist/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/${FILENAME}"
fi

echo "Downloading Zookeeper from $url"

cd /tmp

wget "${url}" -O "${FILENAME}"
wget -q "https://www.apache.org/dist/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/${FILENAME}.asc"

wget -q https://www.apache.org/dist/zookeeper/KEYS

gpg --import KEYS
gpg --verify "${FILENAME}.asc"
mv ${FILENAME} /zookeeper.tar.gz