FROM ruby:2.7-buster
RUN apt-get update -qq && apt-get install --no-install-recommends -y wkhtmltopdf default-libmysqlclient-dev nodejs
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

ENV RAILS_ENV=production
# Start the main process.
CMD ["bundle", "exec", "rails", "server", "-e", "production", "-b", "0.0.0.0"]
