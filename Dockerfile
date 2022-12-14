FROM ruby:2.7
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs npm postgresql-client imagemagick
RUN npm install --global yarn
RUN mkdir /myapp
WORKDIR /myapp
ADD package.json /myapp/package.json
RUN yarn add jquery@3.4.1 bootstrap@3.4.1

ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
ADD . /myapp

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 4000
CMD ["rails", "server", "-b", "0.0.0.0"]
