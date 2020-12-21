#!/bin/bash -e

## Prerequisite: need cut & curl & wget & jq & gpg installed; ZOOKEEPER_VERSION set

source "/tmp/versions.sh"

FILENAME="kafka_${KAFKA_SCALA_VERSION}-${KAFKA_VERSION}.tgz"

url=$(curl --stderr /dev/null "https://www.apache.org/dyn/closer.cgi?path=/kafka/KAFKA_VERSION/${FILENAME}&as_json=1" | jq -r '"\(.preferred)\(.path_info)"')
if [[ ! $(curl -s -f -I "${url}") ]]; then
    echo "Mirror does not have desired version, downloading direct from Apache"
    url="https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/${FILENAME}"
fi

echo "Downloading Zookeeper from $url"

cd /tmp

wget "${url}" -O "${FILENAME}"
wget -q "https://www.apache.org/dist/kafka/${KAFKA_VERSION}/${FILENAME}.asc"

wget -q https://www.apache.org/dist/kafka/KEYS

gpg --import KEYS
gpg --verify "${FILENAME}.asc"
mv ${FILENAME} /kafka.tar.gz