# keep our base image as small as possible
FROM docker.io/nginx/unit:1.22.0-node15
LABEL maintainer="Dilip Kr. Shukla <fusionstrings@gmail.com>"

# https://docs.docker.com/engine/reference/builder/#environment-replacement
# ARG NODE_ENV=development

# Default is "production"
ARG NODE_ENV
ENV NODE_ENV=${NODE_ENV:-production}
RUN echo $NODE_ENV

# Create app directory
WORKDIR /www

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package.json package-lock.json *yarn* ./

RUN npm install
# same as "working_directory" in config.json
COPY www/app.js ./app.js
COPY ./.unit/config-static.json /docker-entrypoint.d/config.json
COPY ./public ./public
COPY ./src ./modules

RUN ls

#RUN npm install -g unit-http && npm link unit-http
# make app.js executable; link unit-http locally
RUN ["chmod", "+x", "app.js"]

# port used by the listener in config.json
EXPOSE 80
