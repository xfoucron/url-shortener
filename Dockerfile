FROM ruby:3.1.2-slim AS assets

WORKDIR /app

RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential curl git libpq-dev \
  && curl -sSL https://deb.nodesource.com/setup_16.x | bash - \
  && curl -sSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo 'deb https://dl.yarnpkg.com/debian/ stable main' | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update && apt-get install -y --no-install-recommends nodejs yarn \
  && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man \
  && apt-get clean \
  && useradd --create-home ruby \
  && mkdir /node_modules && chown ruby:ruby -R /node_modules /app

USER ruby

COPY --chown=ruby:ruby Gemfile* ./
RUN bundle install --jobs 4

COPY --chown=ruby:ruby package.json *yarn* ./
RUN yarn install

ENV RAILS_ENV="production" \
    NODE_ENV="production" \
    PATH="${PATH}:/home/ruby/.local/bin:/node_modules/.bin" \
    USER="ruby"

COPY --chown=ruby:ruby . .

RUN SECRET_KEY_BASE=urlshortener rails assets:precompile

CMD [ "bash" ]


FROM ruby:3.1.2-slim AS app

WORKDIR /app

RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential curl libpq-dev \
  && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man \
  && apt-get clean \
  && useradd --create-home ruby \
  && chown ruby:ruby -R /app

USER ruby

COPY --chown=ruby:ruby bin/ ./bin
RUN chmod 0755 bin/*

ENV RAILS_ENV="production" \
    PATH="${PATH}:/home/ruby/.local/bin" \
    USER="ruby"

COPY --chown=ruby:ruby --from=assets /usr/local/bundle /usr/local/bundle
COPY --chown=ruby:ruby --from=assets /app/public /public
COPY --chown=ruby:ruby . .

EXPOSE 80

ENTRYPOINT [ "/app/docker-entrypoint" ]
CMD [ "rails", "s", "-p", "80", "-b", "0.0.0.0" ]