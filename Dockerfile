FROM ruby:2.7

RUN gem install bundler

COPY Gemfile .
COPY Gemfile.lock .
COPY config.ru .
COPY sidekiq-monitor-entrypoint.sh /usr/local/bin/

RUN bundle install

ENTRYPOINT ["sidekiq-monitor-entrypoint.sh"]
EXPOSE 9292