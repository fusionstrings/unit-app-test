FROM node:15
LABEL maintainer="Dilip Kr. Shukla <dilip.shukla@comeon.com>"

# https://docs.docker.com/engine/reference/builder/#environment-replacement
# ARG NODE_ENV=development

# Default is "production"
ARG NODE_ENV
ENV NODE_ENV=${NODE_ENV:-production}
RUN echo $NODE_ENV

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package.json *yarn* ./

RUN yarn
# If you are building your code for production
# RUN npm install --only=production

# Bundle app source
COPY . .

EXPOSE 8080
EXPOSE 3000
EXPOSE 3001

HEALTHCHECK CMD wget -q -O /dev/null http://localhost:8080/healthy || exit 1

CMD [ "yarn", "dev" ]
