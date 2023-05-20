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

# do modifications to your Dockerfile(optimize build layers)
# copy package.json file & install dependencies first, then we copy files
# [key] In Dockerfile, we need to put less changed files in the top( stable instructions ), and frequently changed files to the bottom( changing instructions )
COPY . .
RUN npm install
=>
COPY package*.json .
RUN npm install
COPY . .

```

## Links
Base Image Samples: https://docs.docker.com/samples/

Find Images: https://hub.docker.com/

## License
MIT