# spark-app

This is a module directory to write the spark application.

## Directory

- `build_scripts/`: scripts for building
- `test_scripts/`: scripts for running example
- `scala-deb-base`: base dockerfile for scala

## Change as you need

### Docker Repository's prefix (registry/organization)

Modify `DOCKER_REPO` in `./.env`

## For Developer

You can use this module to develop scala & spark application with minimal setup.
All scala/spark tools is in the docker container and language support will be installed by VSCode's remote container extension.

### Prerequisite

- The environment for build needs to be linux/amd64 or macos/amd64
- The environemnt for build needs [docker engine installed](https://docs.docker.com/engine/install/)
- The environemnt for build needs GNU `make` > 3.8 installed
- (Optional) If you need language support such as IntelliSense/autocomplite/gotodefinition, this module also provide all you need. To utilize this feature you need [VSCode installed](https://code.visualstudio.com/docs/setup/setup-overview) and the [VSCode Extension: Remote Development Extension Packs](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) installed.

### Step1. Build the scala base image

```bash
make base
```

### Step2. Write your code

You can then write your code located at `./src` as [a standard sbt project directory](https://www.scala-sbt.org/1.x/docs/Directories.html).

Modify `./build.sbt` for project name, scala version, spark version, ...

If you need rich IDE features during coding, you can run in `vscode` and execute `Remote-Containers: Open Folder in Container` and select the root directory of this module.
Then VSCode will build a dev-container and run it based on `./.devcontgainer/devcontainer.json`.
The whole directory will be mounted to `/root/workspace`.

After attached to the dev-container, run `Metals: Import Build` in vscode to use the `scala-metal` extension, which support autocomplete/go to definition/....

### Step2. Build your scala/spark application into jar during development

When you in the dev-container in vscode or `make run-base`,

```bash
cd /root/workspace
sbt clean assembly
```
or
```bash
make sbt-assembly
```

The assembly jar will be placed in somewhere like `/root/workspace/target/scala-2.12/project-name-assembly-1.0.jar`. 
Check `./build.sbt` for details.

And use this command to run during development

```bash
make sbt-run
```
or
```bash
sbt "run conf"
```

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
make delete-images
```

Or you can check `./Makefile` for more details.

## How to run

### Prerequisite

- build based on the above section
- have [docker-compose](https://docs.docker.com/compose/install/) installed

### Run command

```bash
make run
```