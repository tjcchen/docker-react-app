## Docker React App
A front-end application bootstrapped with Docker.

## Dockerfile
```bash
# Dockerfile instructions
FROM       # base image
WORKDIR    # working directory
COPY       # copy files and directories
ADD        # add files and directories( url and zip file support )
RUN        # execute operating system commands( eg: linux commands )
ENV        # setting environment variables
EXPOSE     # starting on a given port
USER       # user that runs this application
CMD        # commands
ENTRYPOINT # entrypoint dir & file

# build an image on top of "node:14.21.3-alpine"
docker build -t react-app .
docker images | grep -i react-app

# run a docker image( starts with a shell script, now we can see linux env & node version )
docker run -it react-app sh

# to ignore your node_modules in docker, we need to add a .dockerignore file, then include:
node_modules/

# after we set an environment variable in Dockerfile, we are able to access it like:
Dockerfile: ENV API_URL=https://api.myapp.com/
Linux env: printenv API_URL
Linux env: echo $API_URL

# docker users

# run a alpine linux environment
docker run -it alpine

# add an app group
addgroup app

# check groups
cat /etc/groups

# add an app user with app name
adduser -S -G app app

# check user group
groups app

# create a tjcchen group, and add a tjcchen user
addgroup tjcchen && adduser -S -G tjcchen tjcchen

# add a app user in Dockerfile
RUN addgroup app && adduser -S -G app app

# use the app user
USER app

# reenter the docker container, but this time with app user( since we set permissions )
docker run -it react-app sh

# after we set CMD or ENTRYPOINT instruction in Dockerfile, we can run image directly
directly: docker run react-app
with arguments: docker run react-app npm start

# [important] optimize your docker build speed

# check layer's information( check information from bottom to top )
docker history react-app

# do modifications to your Dockerfile( optimize build layers )
# copy package.json file & install dependencies first, then we copy files
# [key] In Dockerfile, we need to put less changed files in the top( stable instructions ), and frequently changed files to the bottom( changing instructions )
COPY . .
RUN npm install
=>
COPY package*.json .
RUN npm install
COPY . .

# remove images & containers

# remove dangling images( to remove dangling images, be sure to remove stopped containers first )
docker image prune

# remove all exited containers
docker ps -a
docker container prune

# remove docker image
docker image rm <imagename> or docker image rm <imageid>
docker image rm react-app
docker image rm 8b9

# remove stopped docker container
docker rm <containerid>
docker rm 8b9

# remove containers
docker container rm <containerid>
docker rm <containerid>
docker rm -f <containerid> # to force the removal
docker container prune     # to remove stopped containers

# tagging images

# [IMPORTANT] BE SURE TO ALWAYS TAG YOUR IMAGES IN PRODUCTION ENVIRONMENT( Explicit Tags )

# option1: build image along with tag( current version 1, if we don't specify, docker will give it a `latest` tag )
docker build -t react-app:1 .

# remove image by tag
docker image remove react-app:1

# option2: rename a tag after build
docker image tag react-app:latest react-app:1

# rebuild a new image after modifying code
docker build -t react-app:2 .

# rename version 2 to latest( we need to explicitly tag the latest version )
docker image tag <imageid> react-app:latest
docker image tag 3d8db67b7e6e react-app:latest

# sharing images

# step0: login to your docker hub via terminal
docker login

# step1: create an image in your docker hub, usually with the same local name

# step2: rename your local image to a remote image
docker image tag react-app:2 tjcchen/react-app:2

# step3: push to docker hub
docker push tjcchen/react-app:2

# step4: modify some code & rename again
docker build -t react-app:3 .
docker image tag react-app:3 tjcchen/react-app:3 ( after some modification )

# step5: push new version to docker hub
docker push tjcchen/react-app:3

# step6: we can pull docker image from any machine
docker pull tjcchen/react-app:3

# saving and loading images( transfer images without Docker Hub )

# check saving commands
docker image save --help

# save react-app image as a .tar file( then we got a .tar file in current directory, this .tar file contains layered information )
docker image save -o react-app.tar react-app:3

# image load commands
docker image load --help

# delete local images & use untar image( then we got react-app:3 image locally )
docker image load -i react-app.tar

# starting and stopping containers
docker stop <containerid>
docker start <containerid>

# [deployment] mapping host port to container port( in this case, we map host port 80 to container 3000 )
docker run -it -p 80:3000 react-app:4

# volumes
# volume command is used to mount folders data between host and container

# print current folder file content to terminal
find . -type f -exec cat {} \;

# list all volumes
docker volume ls

# create an volume
docker volume create app-data

# inspect the volume data
docker volume inspect app-data

# mount volumes
docker run -v app-data:/app/data <image>

# Copying files between the host and containers
docker cp <containerid>:app/log.txt .    # from container to host
docker cp secret.txt <containerid>:/app  # from host to to container

# sharing source code with containers( use a absolute path )
# eg: config files or text files
docker run -v $(pwd):/app <image>
```

```bash
# run a container in detach mode( in background )
docker run -d react-app

# give the running docker a name
docker run -d --name blue-sky react-app

# check container logs
docker logs <containerid>
docker logs 516294f41dc9

# check more logs arguments
docker logs --help

# check last 5 lines of logs with timestamp
docker logs -n 5 -t 516294f41dc9

# publishing port

# mapping host 80 port to container 3000 port
docker run -d -p 80:3000 --name c1 react-app

# execute command in a running container
docker exec <containername> <command>
docker exec c1 ls

# execute command in a running container in an interactive way
docker exec -it c1 sh
```

## Links
Base Image Samples: https://docs.docker.com/samples/

Find Images: https://hub.docker.com/

## License
MIT