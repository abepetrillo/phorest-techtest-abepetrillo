FROM circleci/ruby:2.6.6-stretch-node
USER root
ENV APP_HOME /myapp
ENV BUNDLE_PATH /cache
ENV DB_HOST db

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile $APP_HOME
ADD Gemfile.lock $APP_HOME
ADD . $APP_HOME

EXPOSE 3000
CMD ["rails", "server"]
