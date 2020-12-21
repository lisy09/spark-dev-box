# kafka-docker

This is a module to dockerize kafka/zookeeper for spark streaming application.

It is inspired by [wurstmeister/kafka-docker](https://github.com/wurstmeister/kafka-docker) and [wurstmeister/zookeeper-docker](https://github.com/wurstmeister/zookeeper-docker).

## Directory

- `zookeeper`: dockerfile for zookeeper
- `build_scripts/`: scripts for building
- `test_scripts/`: scripts for running example

## Change as you need

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

```bash
make deploy
```

undeploy
```bash
make undeploy
```