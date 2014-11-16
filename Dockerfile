FROM ruby:2.1.2

# Do this not as root

EXPOSE 8081

ADD . /usr/src/

# Set up node.js
RUN apt-get update
RUN apt-get install -y nodejs npm
WORKDIR /usr/src/code_server
RUN npm install

ENTRYPOINT ["/usr/bin/nodejs", "index.js"]
