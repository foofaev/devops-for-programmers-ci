FROM node:14

COPY ./ /srv/project

WORKDIR /srv/project/

RUN npm clean-install
