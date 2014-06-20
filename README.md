This is a Dockerfile setup for plexWatch (https://github.com/ljunkie/plexWatch) and plexWatchWeb (https://github.com/ecleese/plexWatchWeb)

Setup:

Follow steps 1 through 3 and ONLY steps 1 through 3 here: https://github.com/ljunkie/plexWatch#install

To run:

docker run -d --net="host" --name="plexWatch" -v /path/to/plexWatch:/plexWatch -v /path/to/plex/logs:/logs -p 8080:8080 needo/plexwatch

To access plexWatchWeb visit:

http://server:8080/plexWatch/

Troubleshooting:

Log files of plexWatch is available where you installed plexWatch.pl for troubleshooting.
