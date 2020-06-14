FROM ruby:2.6.3-alpine

ENV BUILD_PACKAGES build-base postgresql-dev tzdata
ENV RUBY_PACKAGES nodejs redis

RUN apk add --update --no-cache \
    $BUILD_PACKAGES \
    $RUBY_PACKAGES

RUN gem install rails -v '5.2.0'

WORKDIR /app

RUN echo $RUBY_VERSION > .ruby-version
ADD Gemfile Gemfile.lock /app/
RUN bundle install