FROM ruby:2.3.1-alpine

WORKDIR /opt/actioncenter

RUN apk add --update --no-cache libpq qt5-qtbase-dev qt5-qtwebkit-dev xvfb xauth git build-base postgresql-dev linux-headers libxml2-dev libxslt-dev

ADD Gemfile* ./

RUN bundle config build.nokogiri --use-system-libraries
RUN PATH="$PATH:/usr/lib/qt5/bin/" bundle install --jobs=4

ADD bin/ ./bin
ADD config/ ./config
ADD config.ru ./
ADD Rakefile ./
ADD Procfile ./
ADD db/ ./db
ADD lib/ ./lib
ADD public/ ./public
ADD app/ ./app
ADD features/ ./features
ADD script/ ./script
ADD spec/ ./spec
ADD vendor/ ./vendor
ADD docker/ ./docker

CMD ["rails", "s", "-b", "0.0.0.0"]
ENTRYPOINT ["/opt/actioncenter/docker/entrypoint.sh"]
