## Cpanel backups

Taking full backups of (shared/reseller) web hosting is as easy as using the built in Backup tool in Cpanel.

If you are using a reseller environment with WHM then using a dedicated tool like [WHMEZBackup](https://whmeasybackup.com/) makes more sense as you can automatically back up all Cpanels at once.

If you're doing it Cpanel-by-Cpanel for whatever reason, then follow these steps.

## Navigate to 'Backup' in your Cpanel

It can be found here

![backup](/images/cpanel1.png)

Then select a 'full backup'. This will capture not only the files but also the MySQL, email accounts and forwarders.

Next, you donwload the archive:

![backup](/images/cpanel2.png)

You can use an EC2 instance to download the resulting image over wget and then use rclone to move it up to B2 or S3:

s3cmd -v put mybackup.tar.gz s3://mybackupbucket

Some providers also support direct cloud to cloud backup functionality natively.

This is obviously a full, rather than incremental, backup approach — many hosting providers include tools like JetBackup that take care of the latter, although these are obviously managed by the service provider.






