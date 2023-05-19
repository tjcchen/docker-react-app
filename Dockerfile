# base image
FROM node:14.21.3-alpine

# add an app group, and add an app user
RUN addgroup app && adduser -S -G app app

# use the app user
USER app

# set target folder to app, thus we no longer need to rewrite /app folder in COPY instruction
WORKDIR /app

# copy directories( use add if you want to apply url or a zip file, the docker will unzip it )
COPY . .

# install npm dependencies, after we ignore node_modules in .dockerignore
RUN npm install

# set environment variables( eg: a frontend server needs to call backend services )
ENV API_URL=https://api.myapp.com/

# expose a 3000 application port( just for documentation purpose )
EXPOSE 3000

# run an bootstrap command, we can only one CMD in a Dockerfile
# differences between RUN and CMD
# RUN: RUN is a `build time instruction`, and is executed when building the image. The result dependencies is stored in images
# CMD: In contrast, CMD is a `run time instruction`, it is executed when starting a container
# Shell form( start with /bin/sh ): CMD npm start
# Execute form( use this form, this form is faster in cleaning resources ): CMD ["npm", "start"]
# Can be overwritten from command line: docker run react-app echo hello
CMD ["npm", "start"]

# similar to CMD instruction, but difficult to overwrite: docker run react-app --entrypoint npm start
# ENTRYPOINT [ "npm", "start" ]
