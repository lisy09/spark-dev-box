# spark-dev-box

Origin: https://github.com/lisy09/spark-dev-box

This is a project to provide a practical dev suite for scala spark.

## Directory

- `spark-app/`: module directory to write the spark application
- `vendor/hadoop-docker`: vendor hadoop to provider 

## How to run

### Prequisuite

build all docker images in:
- kafka-docker
- vendor/hadoop-docker
- vendor/apache-livy-docker
and the spark application jar in :
- spark-app/build_results/spark-app.jar

You can do this in one command:
```bash
make all
```

### Step1. Deploy dev cluster in docker-compose

```bash
make deploy
```

### Step2. Submit spark streaming application through apache-livy REST API

*Need `curl` installed*

```bash
make submit
```

### Step3. Start the kafka client to produce streaming data

```bash
make send-batch
```

### Step4. Check latest state stored at redis through a HTTP server

```bash
curl -X GET "http://localhost:8001/v1/wordcount" -H  "accept: application/json"
```

or check the API GET /v1/wordcount at http://localhost:8001/docs

### StepX. Undeploy

```bash
make undeploy
```