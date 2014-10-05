#!/bin/bash

# download plexWatch.pl if it doesn't already exist
if [ ! -f /plexWatch/plexWatch.pl ]; then
  echo "Downloading plexWatch.pl..."
  wget -P /plexWatch/ https://raw.github.com/ljunkie/plexWatch/master/plexWatch.pl
  chmod +x /plexWatch/plexWatch.pl
fi

# download the default plexWatch config.pl file if it doesn't already exist
if [ ! -f /plexWatch/config.pl ]; then
  echo "Downloading plexWatch config.pl"
  wget -P /plexWatch/ https://raw.github.com/ljunkie/plexWatch/master/config.pl-dist
  mv /plexWatch/config.pl-dist /plexWatch/config.pl
  chmod a+w /plexWatch/config.pl
  # set the data_dir location
  sed -i -e "s#\(data_dir = '\).*'#\1/plexWatch/'#" /plexWatch/config.pl
fi

# set server_log in the plexWatch config.pl file
if [ -f /logs/Plex\ Media\ Server.log ]; then
  echo "Plex Media Server.log located in /logs directory"
  sed -i -e "s#\(server_log = '\).*'#\1/logs/Plex Media Server.log'#" /plexWatch/config.pl
elif [ -f /log/Plex\ Media\ Server.log ]; then
  # some users may pass in /log instead of /logs
  echo "Plex Media Server.log located in /log directory"
  sed -i -e "s#\(server_log = '\).*'#\1/log/Plex Media Server.log'#" /plexWatch/config.pl
else
  echo "Error: Unable to locate the 'Plex Media Server.log' file. Did you pass in the correct path?"
  exit 1 # terminate and indicate error
fi

# use the default plexWatchWeb config.php file if it doesn't already exist
if [ ! -f /plexWatch/config.php ]; then
  echo "Using default plexWatchWeb config.php"
  cp /tmp/config.php /plexWatch/config.php
  chmod a+w /plexWatch/config.php
fi
