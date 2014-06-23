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
RUN apt-get install -qy apache2 libapache2-mod-php5 wget php5-sqlite

# Enable PHP
RUN a2enmod php5

# Delete the annoying default index.html page
RUN rm -f /var/www/html/index.html

# Update apache configuration with this one
ADD apache-config.conf /etc/apache2/sites-available/000-default.conf
ADD ports.conf /etc/apache2/ports.conf

# Install plexWebWatch v1.5.4.2
RUN mkdir -p /var/www/html/plexWatch
RUN wget -P /tmp/ https://github.com/ecleese/plexWatchWeb/archive/v1.5.4.2.tar.gz
RUN tar -C /var/www/html/plexWatch -xvf /tmp/v1.5.4.2.tar.gz --strip-components 1
RUN chown www-data:www-data /var/www/html/plexWatch

# Set config.php to under plexWatch
RUN ln -s /plexWatch/config.php /var/www/html/plexWatch/config/config.php

# Manually set the apache environment variables in order to get apache to work immediately.
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

EXPOSE 8080

# The plexWatch directory. Where the binary, config, and database is
VOLUME /plexWatch

# Plex Logfile directory for IP addresses
VOLUME /log

ADD start.sh /start.sh

CMD ["/bin/bash", "/start.sh"]
