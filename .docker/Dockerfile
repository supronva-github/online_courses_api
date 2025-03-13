FROM ruby:2.7.6

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

RUN chmod +x /app/.docker/entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["/app/.docker/entrypoint.sh"]

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
