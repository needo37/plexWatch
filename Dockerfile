FROM debian:jessie
MAINTAINER needo <needo@superhero.org>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q

# Install plexWatch Dependencies
RUN apt-get install -qy libwww-perl libxml-simple-perl libtime-duration-perl libtime-modules-perl libdbd-sqlite3-perl perl-doc libjson-perl libfile-readbackwards-perl cron

# Add our crontab file
ADD crons.conf /root/crons.conf

# Use the crontab file
RUN crontab /root/crons.conf

# Install plexWebWatch Dependencies
RUN apt-get install -qy apache2 libapache2-mod-php5 git php5-sqlite

# Enable PHP
RUN a2enmod php5

# Delete the annoying default index.html page
RUN rm -f /var/www/html/index.html

# Checkout plexWebWatch from github
RUN git clone https://github.com/ecleese/plexWatchWeb.git /var/www/html/plexWatch

# Set config.php to under plexWatch
RUN ln -s /plexWatch/config.php /var/www/html/plexWatch/config.php

# Manually set the apache environment variables in order to get apache to work immediately.
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

EXPOSE 80

# The plexWatch directory. Where the binary, config, and database is
VOLUME /plexWatch

# Plex Logfile directory for IP addresses
VOLUME /log

ADD start.sh /start.sh

CMD ["/bin/bash", "/start.sh"]
