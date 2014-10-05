This is a Dockerfile for plexWatch (https://github.com/ljunkie/plexWatch) and plexWatchWeb (https://github.com/ecleese/plexWatchWeb)

Prerequisites
----------

* You must have Plex installed in a docker, running in host mode.  Needo's Plex docker (https://registry.hub.docker.com/u/needo/plex/) is recommended
* You must have a Plex Pass


Upgrade Instructions
----------

* Stop the container, delete the container, and follow the new installation instructions.
* Note: if you are having any problems at all with your existing container, delete config.pl and config.php to start fresh.


New Installation Instructions
----------

* Start watching a movie in Plex, leave it running
* Run the docker in host mode:
```
docker run -d --net="host" --name="plexWatch" -v "/path/to/plexWatch/":"/plexWatch":rw -v "/path/to/plex/logs/":"/logs":ro -v /etc/localtime:/etc/localtime:ro -p 8080:8080 needo/plexwatch
```
Where: 
   * plexWatch:
      - the path in the container should be "/plexWatch"
      - the path on the array should be something like "/mnt/cache/cache_only/plexWatch/"
        (this directory will contain the config.pl and config.php files you may need to edit)
      - the container needs read/write access
      - example:  "/mnt/cache/cache_only/plexWatch/":"/plexWatch":rw

   * logs:
      - the path in the container should be "/logs"
      - the path on the array should be something like "/mnt/cache/appdata/Plex/Library/Application Support/Plex Media Server/Logs/"
        (this directory should contain a file named "Plex Media Server.log")
      - the container needs read only access
      - example:  "/mnt/cache/appdata/Plex/Library/Application Support/Plex Media Server/Logs/":"/logs":ro


* Try it out: http://server:8080/plexWatch/

If all goes well, plexWatchWeb will load and show you the movie that is currently playing in Plex.

If the container stops immediately or you get an error message, see the "Troubleshooting" section.


Host mode vs Bridge mode
----------

The easiest way to setup the plexWatch docker is to run it in host mode.  But if you would like to run it in bridge mode:
* Change the "server" value in config.pl and the "pmsIp" value in config.php from "localhost" to the ip address of your server.
   * Note: If you ever switch back to host mode, change those values back to "localhost"
* Put your Plex username and password in both the config.pl and config.php files.

Then run the plexWatch docker in bridge mode:
```
docker run -d --net="bridge" --name="plexWatch" -v "/path/to/plexWatch/":"/plexWatch":rw -v "/path/to/plex/logs/":"/logs":ro -v /etc/localtime:/etc/localtime:ro -p 8080:8080 needo/plexwatch
```

Note that Plex itself should still be run in host mode.

Track IP Addresses
----------

If you want to track the IP Addresses of your Plex users:
* Login to Plex and go to Settings -> Server -> Network and click Show Advanced.  Then enable debug logging.
* Modify config.pl and change $log_client_ip from 0 to 1
* After a few minutes, plexWatch will start tracking IP addresses


Troubleshooting
----------

To read the docker logs:
* From the unRAID docker manager, click on the status/log column
* Or from a shell type "docker logs plexWatch"

Common errors:

* If the log shows "Unable to locate the 'Plex Media Server.log' file":
   - Check your paths as described in the "New Installation Instructions" section.  Capitalization matters.

* If the log shows: "AH00558: apache2: Could not reliably determine the server's fully qualified domain name..."
   - It is safe to ignore this message

* If plexWatchWeb loads, but gives a "Failed to access plexWatch database" error message:
   - Login to Plex and go to Settings -> Server -> Connect.  Verify that the account you are signed in as has a Plex Pass.
   - Start watching a movie, wait a few minutes, then try accessing plexWatchWeb again.

* If plexWatchWeb loads, but gives a "Failed to access Plex Media Server" error message:
   - Ensure the Plex docker is running(!) and is in host mode
   - Review the "Host mode vs Bridge mode" section.  It is likely that the wrong server ip or wrong username/pasword is specified in the config files.
     The same details need to be provided in both config.pl and config.php.

* Still having problems?
   - Review the docker log as described above
   - Review the debug.log file located in your plexWatch directory
   - If you have edited config.pl or config.php, delete them and restart the docker to start fresh
