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

# tagging images

# [IMPORTANT] BE SURE TO ALWAYS TAG YOUR IMAGES IN PRODUCTION ENVIRONMENT( Explicit Tags )

# build image along with tag( current version 1, if we don't specify, docker will give it a `latest` tag )
docker build -t react-app:1 .

# remove image by tag
docker image remove react-app:1

# rename a tag after build
docker image tag react-app:latest react-app:1

# rebuild a new image after modifying code
docker build -t react-app:2 .

# rename version 2 to latest( we need to explicitly tag the latest version )
docker image tag <imageid> react-app:latest
docker image tag 3d8db67b7e6e react-app:latest

```

## Links
Base Image Samples: https://docs.docker.com/samples/

Find Images: https://hub.docker.com/

## License
MIT