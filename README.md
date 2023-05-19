## Docker React App
A front-end application bootstrapped with Docker.

## Dockerfile
```bash
# Dockerfile instructions
FROM       # base image
WORKDIR    # working directory
COPY       # copy files and directories
ADD        # add files and directories
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

```

## Links
Base Image Sample: https://docs.docker.com/samples/

Find Images: https://hub.docker.com/

## License
MIT