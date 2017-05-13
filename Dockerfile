FROM ruby:2.4.1-alpine
MAINTAINER Javier Juarez <javier.juarez@gmail.com>

LABEL "version"="1.0" \
      "service"="sinatra" \
      "description"="A minimal Sinatra application"

ARG APP_HOME
ENV APP_HOME ${APP_HOME:-/app}
ARG APP_PORT
ENV APP_PORT ${APP_PORT:-9292}

ADD Gemfile* $APP_HOME/
RUN apk --update add --virtual build-dependencies ruby-dev build-base && \
    gem install bundler --no-ri --no-rdoc && \
    cd $APP_HOME; bundle install --without development test -j 4 && \
    apk del build-dependencies build-base

ADD app.rb config.ru $APP_HOME/
RUN chown -R nobody:nogroup $APP_HOME
USER nobody

EXPOSE $APP_PORT
WORKDIR $APP_HOME

