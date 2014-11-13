FROM ruby:2.1.2

# Do this not as root

EXPOSE 8081

ADD . /usr/src/

WORKDIR /usr/src
RUN bundle install

ENTRYPOINT ["ruby", "server.rb"]
