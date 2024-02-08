# FIRST STAGE
# bring debian image
FROM debian:latest AS build-env

# install dependencies
RUN apt-get update
# git for cloning flutter, curl and unzip for downloading and extracting dart SDK
RUN apt-get install -y curl git unzip

ARG FLUTTER_SDK=/usr/local/flutter
ARG FLUTTER_VERSION=3.10.5

# cloning flutter
RUN git clone https://github.com/flutter/flutter.git $FLUTTER_SDK
RUN cd $FLUTTER_SDK && git fetch && git checkout $FLUTTER_VERSION

ENV PATH="$FLUTTER_SDK/bin:$FLUTTER_SDK/bin/cache/dart-sdk/bin:${PATH}"

# create new directory for the app
RUN mkdir /app

# copy the app to the newly created directory on the container
COPY . /app

# change working directory to the app's directory
WORKDIR /app

# go to flutter's latest stable channel (beta)
RUN flutter channel beta
RUN flutter upgrade
# delete the build/ and .dart_tool/ directories.
RUN flutter clean
# get the current package's dependencies.
RUN flutter pub get
# build the web app
RUN flutter build web

# SECOND STAGE
FROM nginx:1.25.2-alpine

# use the output of the previous stage (build-env) and copy it to the nginx's default directory
COPY --from=build-env /app/assets /usr/share/nginx/html/assets
COPY --from=build-env /app/build/web /usr/share/nginx/html

# expose port 80
EXPOSE 80

# run nginx
CMD ["nginx", "-g", "daemon off;"]

