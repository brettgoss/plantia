FROM ruby:2.5-alpine

RUN apk add --update \
    build-base \
    postgresql-dev \
    tzdata \
    nodejs \
    redis

RUN gem install rails -v '5.2.0'

WORKDIR /app

RUN echo "2.5.4" > .ruby-version
ADD Gemfile Gemfile.lock /app/
RUN bundle install