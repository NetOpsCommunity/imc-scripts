This is a proof of concept script that can be used to provide delayed alarming of node down events in IMC. Customer challenge is that IMC will immediately send an email alert if a device goes offline. We would like to insert a delay into this, so we only alert if the device is down for more than 5 minutes.

The RIGHT way to do this by using the eAPI, but not everyone has eAPI licenses. So this script looks directly at the database, and figures out which systems have an active "Node Down" alarm, that has been outstanding for more than 5 minutes, and not recovered.

You'll need to edit the script to set your DB settings, email server/destination, etc. This should then be scheduled to run every minute.

The script connects to the DB, pulls a list of node down alarms, tries to figure out if it's already sent an alert for them, and if it hasn't, it sends an email. It then remembers which alarms it's seen before, so it doesn't re-alarm.

This will only work with IMC on Windows, using SQL Server. Currently only tested with a local SQL server too - needs fixing to work with remote SQL server.


TODO:
 * Fix "invoke-sqlcmd" call to make sure that it works with remote DB - it does NOT work currently. Has only been tested as working with a local SQL Express instance.
 * Separate config into separate file, so script updates can be rolled out easier
 * Extract more information about the device, such as location, etc
 * Document it better. Code comments, etc.
 * Figure out a way to control which devices alert on, based on time of day - e.g. alert for some device groups 24/7, others 8/5.
 * Add error-checking, etc. Basically doesn't do any right now.
