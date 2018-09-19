FROM ruby:2.5.1-alpine3.7

ENV APP_ENV production
EXPOSE 4567

RUN mkdir -p /myapp
WORKDIR /myapp
COPY Gemfile Gemfile
RUN bundle install --without test

COPY population.csv population.csv
COPY server.rb server.rb
COPY views views

CMD ruby server.rb
