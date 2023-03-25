# Docker

https://docs.docker.com/engine/reference/commandline/docker/

## Images

List the local images:

```
docker images
```

Pull an image from the Docker repository or from a specific repo:

```
docker pull [image-name]:[version]

docker pull [repo]/[image-name]:[version]
```

Build the current directory's Dockerfile into an image:

```
docker build -t [image-name]:[version] .
```

Remove an image or remove all images:

```
docker rmi [image-name]:[version]

docker rmi -f $(docker images -aq)
```

## Containers

Run an image as a container and in disconnected mode:

```
docker run [image-name]
docker run -p [machine-port]:[container-port] --name [container-name] [image-name]

docker run -d [image-name]
docker run -p [machine-port]:[container-port] --name [container-name] -d [image-name]
```

List the running containers and include stopped containers:

```
docker ps

docker ps -a
```

Stop a running container or stop all running containers:

```
docker stop [container-name]

docker stop $(docker ps -q)
```

Remove a container or remove all containers:

```
docker rm [container-name]

docker rm $(docker ps -aq)
```

View the logs from a container and in follow mode:

```
docker logs [container-id]
docker logs [container-name]

docker logs -f [container-name]
```

Start a bash session inside a running container:

```
docker exec -it [container-name] bash
```

Inspect a container's metadata and filter for a specific field:

```
docker inspect [container-name]

docker inspect --format='[filter]' [container-name]

docker inspect \
--format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' \
[container-name]
```

## Repositories

### Google Cloud

First, create a Docker artifact repository in the cloud. Second, navigate to the directory that has the Dockerfile.

Authenticate to a Docker artifact repository in Google Cloud:

```
gcloud auth configure-docker [repo-location-name].pkg.dev
```

Build an image for the artifact repository:

```
docker build -t [repo-location-name].pkg.dev/[project-id]/[repository-name]/[image-name]:[version] .
```

Push the image to the artifact repository:

```
docker push [repo-location-name].pkg.dev/[project-id]/[repository-name]/[image-name]:[version]
```
