FROM ubuntu:trusty
MAINTAINER Kaito Udagawa <umiiro.hacker@gmail.com>

# Set up Ubuntu Image
RUN sed -ie s!/a!/jp.a! /etc/apt/sources.list
RUN apt-get -y update
RUN apt-get -y upgrade

# Basic Packages
RUN apt-get -y install openssh-server wget

# Deploy owncloud
RUN apt-get -y install apache2
RUN wget -q -O - https://download.owncloud.org/community/owncloud-7.0.2.tar.bz2 | tar xjf - -C /var/www/html

# Install Requirements
RUN apt-get -y install libapache2-mod-php5
RUN apt-get -y install php5-gd php5-curl
RUN apt-get -y install php5-pgsql
RUN a2enmod rewrite

# Application Settings
ADD 000-default.conf /etc/apache2/sites-available/
RUN mkdir /var/www/html/owncloud/data
RUN chown www-data:www-data /var/www/html/owncloud/data
ADD run.sh /
ADD run_sshd.sh /
RUN chmod 0755 /*.sh

# Image Settings
VOLUME /var/www/html/owncloud/config
CMD /run.sh
EXPOSE 80
