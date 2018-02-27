### STAGE 1: Build ###

# We label our stage as 'builder'
FROM ruby:2.3.3 as builder

RUN mkdir /doc
WORKDIR /doc
COPY . .

RUN gem install bundler
RUN apt-get update && apt-get install -y nodejs
RUN bundle install
RUN bundle exec middleman build --clean
RUN pwd
RUN ls


### STAGE 2: Setup ###

FROM nginx:1.13.3-alpine

## Copy our default nginx config
COPY nginx/default.conf /etc/nginx/conf.d/

## Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

## From 'builder' stage copy over the artifacts in dist folder to default nginx public folder
COPY --from=builder /doc/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
