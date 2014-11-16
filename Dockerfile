FROM ruby:2.1.2

# Do this not as root

EXPOSE 8081

ADD . /usr/src/

# Set up non-priviledged user
# Make sure this user has shit permissions and can't really do anything
RUN adduser --disabled-password --gecos '' coder

# Set up node.js
RUN apt-get update
RUN apt-get install -y nodejs npm
WORKDIR /usr/src/code_server
RUN npm install

CMD ["/usr/bin/nodejs", "index.js"]
