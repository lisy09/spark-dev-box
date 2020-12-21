# hadoop-docker

Origin: https://github.com/lisy09/hadoop-docker

This is a project to setup a hadoop cluster on docker on one machine for development/test.

It is inspired by the [big-data-europe/docker-hadoop](https://github.com/big-data-europe/docker-hadoop) project and add additional features.

## Directory

- `build_scripts/`: scripts for building
- `base/`: base docker image, install jdk & hadoop
- `conf/`: hadoop's xml configuration files which should be place under hadoop containers' /etc/hadoop
- `datanode/`: docker image for hadoop datanode
- `namenode/`: docker image for hadoop namenode
- `nodemanager/`: docker image for hadoop nodemanager
- `resourcemanager/`: docker image for hadoop resourcemanager
- `submit/`: example docker image to submit hadoop application, wordcount.jar
- `test_scripts/`: scripts for running example, e.g., wordcount
- `.env`: dotenv config file for building/running

## Change as you need

### Java version

Please refer to the official document [Hadoop Java Versions](https://cwiki.apache.org/confluence/display/HADOOP/Hadoop+Java+Versions) for selecting a java version.

You can modify the Java version in the `./.env` and build all images again by yourself.

This repo is using Java 8 with OpenJDK.

### Hadoop version

You can modify the Hadoop version in the `./.env` and build all images again by yourself.

### Docker Repository's prefix (registry/organization)

Modify `DOCKER_REPO` in `./.env`

### Hadoop configuration files

Modify `./conf/*.xml`

## How to build

### Prerequisite

- The environment for build needs to be linux/amd64 or macos/amd64
- The environemnt for build needs [docker engine installed](https://docs.docker.com/engine/install/)
- The environemnt for build needs GNU `make` > 3.8 installed

### Build command

To build all docker images locally:
```bash
make all
```

To push built docker images to the remote registry:
```bash
make push
```

To delete built local docker images:
```bash
make clean
```

Or you can check `./Makefile` for more details.

## How to run

### Prerequisite

- build based on the above section
- have [docker-compose](https://docs.docker.com/compose/install/) installed

### Run command

**Please modify ./conf/*.xml when you change hadoop version**

To deploy an example HDFS cluster, run:
```bash
docker-compose --env-file .env -f docker-compose.yml up -d
```
or 
```bash
make deploy
```

To undeploy an example HDFS cluster, run:
```bash
docker-compose --env-file .env -f docker-compose.yml down
```
or 
```bash
make undeploy
```

`docker-compose` creates a docker network that can be found by running docker network list, e.g. `dockerhadoop_default`.

Run `docker network inspect` on the network (e.g. `dockerhadoop_default`) to find the IP the hadoop interfaces are published on. Access these interfaces with the following URLs:

- Namenode: http://<dockerhadoop_IP_address>:9870/dfshealth.html#tab-overview
- History server: http://<dockerhadoop_IP_address>:8188/applicationhistory
- Datanode: http://<dockerhadoop_IP_address>:9864/
- Nodemanager: http://<dockerhadoop_IP_address>:8042/node
- Resource manager: http://<dockerhadoop_IP_address>:8088/

To test running the example wordcount job
```bash
make wordcount
```