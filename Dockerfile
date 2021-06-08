ARG IMAGE_TAG=2.7.3-alpine3.13@sha256:19598fc1ef09911a1015c03be08f1b9c881035ea279216153e804d65812b9f31 
FROM ruby:${IMAGE_TAG} AS builder

ARG APP_HOME=/app

RUN apk --no-cache add --virtual build-dependencies build-base ruby-dev

WORKDIR ${APP_HOME}
COPY Gemfile Gemfile.lock ./
RUN bundle install


FROM ruby:${IMAGE_TAG} AS runtime
LABEL \
  org.label-schema.name="A Dockerized sinatra application" \
  org.label-schema.description="A minimal Sinatra docker application" \
  org.label-schema.url="https://github.com/jjuarez/docker-sinatra-app"

COPY --from=builder /usr/local/bundle /usr/local/bundle

WORKDIR ${APP_HOME}
COPY . ./

EXPOSE 4567/TCP
CMD [ "bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567" ]
