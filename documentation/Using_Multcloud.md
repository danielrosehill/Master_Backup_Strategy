# Using Multcloud to run cloud to cloud syncs

![](/images/mc1.png)

I’ve written a little bit [about the importance of taking (3–2–1 compliant!) backups](https://linuxhint.com/ubuntu_backups_321/) — whether you’re using to back up your home computer or your web hosting.

Another important component of a comprehensive backup strategy is ensuring that all other data repositories which you maintain in the cloud are themselves backed up somewhere you can manage.

If you back them up to a reliable repository like AWS S3 then you’ve already fulfilled the offsite requirement of 3–2–1. And if you keep a copy of that repository on your local network then you’re all the way there.

Running backups cloud-to-cloud (between servers on the cloud) has a major advantage compared to pushing up local backups from your computer: you benefit from the far superior connection (and specifically the uplink) that a professionally managed data center has.

The actual speed of the transfer between cloud sources depends upon the protocol over which the transfer takes place (as well as a few other factors). But you can virtually remain assured that it will be faster than using your home connection.

MultCloud.com is one of my favorite tools for this purpose.

## Connecting Your Cloud

Multcloud’s advantage for backup and data transfer purposes is that it can sync quite a wide variety of clouds — and use different sync methodologies to keep them running as you wish.

![](/images/mc2.png)

The platform supports common “consumer grade” cloud storage tools such as:

- Google Drive
- Mega
- pCloud
- Box

Additionally the tool can connect to:

- ownCloud — a self-hosted file hosting and collaboration suite

You can also connect to:

- AWS S3
- Any FTP server (FTP and FTPS are supported)

And:

- Any WebDAV server
- Any MySQL server

## Connecting and Syncing Clouds

![](/images/mc3.png)

Multcloud can be used to run automatic scheduled syncs between, say, Google Drive and pCloud.

Users can also specify which sync methodology they wish to use — or switch the source and target/destination to change the direction of the sync. A two way sync can also be configured.
The syncing options include:

- Simple one way source to target incremental sync
- Mirror sync (extra files in the target are deleted)
- Move sync full source to target sync

The most important feature — for many users — is the scheduling tool. This allows the sync to run automatically on schedule.

![](/images/mc4.png)

The sync can be configured to run:

- Up to three times daily
- Weekly
- Monthly

## Creating a Cloud Backup Job With Multcloud

Multcloud can be used to automatically sync a cloud storage volume, like pCloud, with a backup bucket in S3.

![](/images/mc5.png)

After connecting the clouds, users simply choose the source and destination.

Set the job to run weekly:

![](/images/mc6.png)

Select “Add Task and Transfer Now” to initiate the transfer and retain the scheduled job:

![](/images/mc7.png)

By clicking on the job icon in the top right hand corner of the screen users can observe the job as it is running. When it is complete, the user receives a confirmation email:

![](/images/mc7.png)



```
