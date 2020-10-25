FROM ruby:2.7.1

# Install nodejs
RUN apt-get update -qq && apt-get install -y nodejs

# Update
RUN apt-get update -y

ADD . /usr/src/app
WORKDIR /usr/src/app

# Install & run bundler
RUN gem install bundler:'~> 2.1.4'

RUN bundle

EXPOSE 3000

CMD ./docker/entrypoint.sh