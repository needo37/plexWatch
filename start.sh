# Start the cron service in the background. Unfortunately upstart doesnt work yet.
cron -f &

# Run the apache process in the foreground, tying up this so docker doesnt ruturn.
/usr/sbin/apache2 -D FOREGROUND
