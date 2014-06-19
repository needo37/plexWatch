This is a Dockerfile setup for plexWatch (https://github.com/ljunkie/plexWatch) and plexWatchWeb (https://github.com/ecleese/plexWatchWeb)

Setup:

Follow steps 1 through 3 and ONLY steps 1 through 3 here: https://github.com/ljunkie/plexWatch#install

To run:

docker run -d --name="plexWatch" -v /path/to/plexWatch:/plexWatch -v /path/to/plex/logs:/logs -p 80:80 needo/plexWatch &

To access plexWatchWeb visit:

http://server/plexWatch/

Troubleshooting:

Log files of plexWatch is available where you installed plexWatch.pl for troubleshooting.
