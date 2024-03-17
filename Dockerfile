FROM ruby:3.3.0

ENV RAILS_ENV=production

RUN adduser --system --group factuur

WORKDIR /app

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update && apt install -y yarn xvfb libnss3 libatk1.0-0

COPY ./Gemfile ./Gemfile.lock /app/

RUN gem install bundler
RUN bundle install

COPY . /app

RUN chown -R factuur:factuur /app

RUN yarn install

RUN bundle exec rails assets:precompile

USER factuur

CMD bundle exec rails s -b 0.0.0.0
