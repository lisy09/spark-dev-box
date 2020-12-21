# kafka-data-producer

This is a module directory for kafka-data-producer, which can provide a REST API interface to recevie data and then work as an kafka provider to proxy the data into kafka.

## Directory

- `build_scripts/`: scripts for building

## Change as you need

### Docker Repository's prefix (registry/organization)

Modify `DOCKER_REPO` in `./.env`

## For Developer

You can use this module to develop kafka-data-producer with python language support by VSCode's remote container extension.

### Prerequisite

- The environment for build needs to be linux/amd64 or macos/amd64
- The environemnt for build needs [docker engine installed](https://docs.docker.com/engine/install/)
- The environemnt for build needs GNU `make` > 3.8 installed
- (Optional) If you need language support such as IntelliSense/autocomplite/gotodefinition, this module also provide all you need. To utilize this feature you need [VSCode installed](https://code.visualstudio.com/docs/setup/setup-overview) and the [VSCode Extension: Remote Development Extension Packs](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) installed.

### Step1. Write your code

You can then write your code located at `./src`.

If you need rich IDE features during coding, you can run in `vscode` and execute `Remote-Containers: Open Folder in Container` and select the root directory of this module.
Then VSCode will build a dev-container and run it based on `./.devcontgainer/devcontainer.json`.
The whole directory will be mounted to `/workspace`.

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

### Run the server in the dev-container

```bash
make deploy-local
```

and then send a test message to the server. (Need kafka running)

```bash
make request-test
```

### Deploy/Undeploy the server with docker-compose

```bash
make deploy
```

undeploy
```bash
make undeploy
```