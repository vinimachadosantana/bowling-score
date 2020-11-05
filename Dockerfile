FROM ruby:2.7.1

COPY . /bowling-score

WORKDIR /bowling-score

RUN gem install bundler && bundle install