FROM ruby:2.6.3-alpine

ENV BUNDLER_VERSION=1.17.2
ENV BUILD_PACKAGES="linux-headers tzdata build-base libffi-dev bash less sqlite-dev sqlite"

RUN apk --update --upgrade add $BUILD_PACKAGES && rm /var/cache/apk/*

RUN mkdir /app
WORKDIR /app

RUN gem install bundler:${BUNDLER_VERSION}

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs=4

COPY . .

EXPOSE 3000
