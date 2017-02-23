FROM selenium/standalone-chrome-debug:latest

MAINTAINER Raphael Adam <raphael.adam@workiva.com, raphael912003@gmail.com>

LABEL Description="This image contains the Selenium-HQ with Chrome and the Dart SDK, as well as AWS CLI"

ENV CHANNEL stable
ENV SDK_VERSION latest
ENV ARCHIVE_URL https://storage.googleapis.com/dart-archive/channels/$CHANNEL/release/$SDK_VERSION
ENV SC_VERSION 4.4.3
ENV PATH $PATH:/usr/lib/dart/bin

RUN apt-get update && apt-get install -y \
    git \
    ssh \
    unzip \
    wget \
    python \
    python-dev \
    python-pip \
  && apt-get clean

RUN pip install awscli boto3

RUN wget -O ./sauce-connect.tar.gz https://saucelabs.com/downloads/sc-$SC_VERSION-linux.tar.gz \
  && tar -zxvf sauce-connect.tar.gz \
  && mv sc-$SC_VERSION-linux/bin/sc /usr/local/bin/ \
  && rm -rf sauce-connect.tar.gz \
  && rm -rf sc-$SC_VERSION-linux/

RUN wget $ARCHIVE_URL/sdk/dartsdk-linux-x64-release.zip \
  && unzip dartsdk-linux-x64-release.zip \
  && cp dart-sdk/* /usr/local -r \
  && rm -rf dartsdk-linux-x64-release.zip
