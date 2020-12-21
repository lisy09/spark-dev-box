# apache-livy-docker

Origin: https://github.com/lisy09/apache-livy-docker

This is a project to provide dockerization of [Apache Livy](https://livy.apache.org/), and provide some other features such as secure access through Kerboros.

## Directory

- `livy_docker`: source of livy docker
- `build_scripts/`: scripts for building
- `test_scripts/`: scripts for running example

## Change as you need

You can modify `./.env` to modify these configurations:
- JAVA version
- Spark version
- Livy version
- Docker repository & tag

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
- need a hadoop cluster when run spark on yarn
  - use https://github.com/lisy09/hadoop-docker in `./vendor/hadoop-docker`

### Run with Hadoop cluster

Modify livy configuration under `./conf/` first.
Please refer to [official repo](https://github.com/apache/incubator-livy/blob/master/conf/livy.conf.template) to check how.

To deploy livy with Hadoop cluster

```bash
make deploy
```

To undeploy
```bash
make undeploy
```

To submit a tested batch spark task through livy api:
```bash
curl -X POST -H "Content-Type: application/json" -H "X-Requested-By: user" -d '{"file":"file:///root/livy-local-files/spark-examples.jar","className":"org.apache.spark.examples.JavaSparkPi"}' http://localhost:8998/batches
```
or
```
make submit
```