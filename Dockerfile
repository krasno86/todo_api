FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /todo_api
WORKDIR /todo_api
COPY Gemfile /todo_api/Gemfile
COPY Gemfile.lock /todo_api/Gemfile.lock
RUN bundle install
COPY . /todo_api
