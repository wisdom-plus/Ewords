FROM ruby:3.1-alpine

WORKDIR /Ewords

ARG USER_ID="10000"
ARG GROUP_ID="10001"
ARG USER_NAME="rails"

RUN addgroup -S -g "${GROUP_ID}" "${USER_NAME}" && \
  adduser -u "${USER_ID}" -G "${USER_NAME}" -D "${USER_NAME}"

COPY Gemfile Gemfile.lock ./

RUN apk  --no-cache add linux-headers\
                        libxml2-dev\
                        make\
                        gcc\
                        libc-dev\
                        nodejs\
                        tzdata\
                        postgresql \
                        postgresql-dev \
                        git \
                        less \
                        imagemagick \
                        yarn \
                        build-base \
                        gcompat &&\
    apk add --virtual build-dependencies --no-cache curl-dev &&\
    bundle install -j4 &&\
    apk del build-dependencies

COPY . .

EXPOSE 3000
