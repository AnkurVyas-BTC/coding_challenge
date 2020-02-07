FROM ruby:2.5.5
RUN gem install bundler
RUN apt-get update && apt-get install -y default-mysql-client
COPY ./docker/app/docker-entrypoint.sh /
RUN mkdir /app
WORKDIR /app

ENTRYPOINT ["/docker-entrypoint.sh"]
