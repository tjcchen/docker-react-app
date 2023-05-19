# base image
FROM node:14.21.3-alpine

# set target folder to app, thus we no longer need to rewrite /app folder in COPY instruction
WORKDIR /app

# copy directories( use add if you want to apply url or a zip file, the docker will unzip it )
COPY . .

# install npm dependencies, after we ignore node_modules in .dockerignore
RUN npm install

# set environment variables( eg: a frontend server needs to call backend service )
ENV API_URL=https://api.myapp.com/

# expose a 3000 application port( just for documentation purpose )
EXPOSE 3000

# add an app group, and add an app user
RUN addgroup app && adduser -S -G app app

# use the app user
USER app
