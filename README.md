# Jenkins Container

* Setup a Jenkins container for CI/CD process on Mac M1.
* Using DinD (Docker in Docker) approach.

## Setup

Build the custom image
```
docker build -t my-jenkins .
```

Run the container with docker-compose
```
docker-compose up
```

Run the container with CLI
```
docker run -d --name my-jenkins -p 8080:8080 -p 50000:50000 \
-v /var/run/docker.sock:/var/run/docker.sock my-jenkins
```

## Plugin Installation

* Install the Jenkins **docker plugin** and the **docker-pipeline plugin**.
* Configure the **docker plugin** through `Manage Jenkins -> Manage Nodes / Cloud -> New Cloud -> Docker -> Create`
  * Docker Host URI: `unix:///var/run/docker.sock`
  * Make sure you check `Enabled`
* Configure the **docker-pipeline plugin** through `Manage Jenkins -> Tools -> Add Docker`
  * Docker version: `latest`
  * Install automatically: `Download from docker.com`
* Restart Jenkins. http://localhost:8080/restart

## Jenkinsfile

Add to pipeline to test.