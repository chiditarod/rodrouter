FROM ruby:2.5.3-slim

RUN apt-get update -qq && \
    apt-get install -y  --no-install-recommends \
      build-essential \
      nodejs \
      libpq-dev

ENV app /app
RUN mkdir /app
WORKDIR /app
ENV BUNDLE_PATH /bundle

RUN gem install bundler
COPY Gemfile Gemfile.lock /app/
RUN bundle install -j 20

COPY . $app

ENTRYPOINT ["/app/docker/entrypoint.sh"]
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
