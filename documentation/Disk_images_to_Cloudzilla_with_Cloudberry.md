# Using Cloudberry to transfer local (full disk) images to the cloud with Cloudberry

![](/documentation/images/11.png)

When it comes to full disk imaging, Clonezilla is one of the most simple and effective low-level tools out there.

Unlike, say, dd, Clonezilla’s sort-of GUI provides plenty of instruction for how to use it effectively through command prompts — and it can be run off a lightweight live USB to back up just about any type of disk or partition (including ext4 filesystems hosting Linux distributions and Windows installs living on NFTS-formatted partitions.)

Clonezilla does support creating backups directly to remote (offsite/cloud storage):

![](/documentation/images/12.png)

Specifically, the tool can can save the backup

- Over SSH
- To a local SAMBA server
- To an NFS server
- To a WebDAV server
- To an AWS S3 server

While this is the most direct means of backing up a Clonezilla image to an offsite location, there are a few significant drawbacks:

- If you’re running Clonezilla in its most simple mode, then you cannot use your computer while the imaging process is taking place
- Over a typical home internet connection, saving a full disk image of say, 30 GB, directly offsite would take days

In light of the above, taking a two-step approach to saving Clonezilla images to the cloud is sometimes the best option.

![](/documentation/images/13.png)

## 1. Save Your Clonezilla Image Locally — Or Copy To Your Desktop From an External Source
To do this, save your Clonezilla disk image locally.
You can either mount a local directory as
```
/home/partimag
```

Or else you can save your offsite to your usual ‘onsite’ location (mine is a WD Elements external hard drive) and then copy the image over. 

E.g.:

```
sudo cp -r /home/media/user/WD_Elements/DesktopBackupDDMMYY /backup_images/
```

If the image is large and you would like to keep abreast of progress as the copy runs then consider using rsync instead of cp:

```
sudo rsync --progress /home/media/user/WD_Elements/DesktopBackupDDMMYY /backup_image/
```

## 2. Create A Backup Plan in Cloudberry

MSP360 (formerly Cloudberry) make a backup client for Linux and Windows.

The program can be purchased for a lifetime perpetual license of $29.99 (at the time of writing). This pro version includes advanced features like compression and encryption. But the basic (freeware) version contains everything needed to push (unencrypted uncompressed) backups to the cloud. (Note: Clonezilla supports compression in its advanced mode).
Of course, you could also use a CLI like rclone to get the job done — but, despite being a longtime Linux user, I don’t believe in making life difficult for no reason!
After selecting “Create a Backup Plan” in Cloudberry Backup I went ahead and added a bucket I created in Backblaze just for Clonezilla images:

![](/documentation/images/14.png)

I then gave the backup plan a name and provided the software with the location of my Clonezilla image. It can be set to run when you are ready to push to the cloud.

![](/documentation/images/15.png)

It’s also useful to think about whether the ‘do not backup hidden file’ option — by default disabled — needs to be enabled.
Of course, if you wanted to build a (very) simple Bash script, or just run a command, you could execute

```
#!/bin/bash
sudo rclone -v sync /home/daniel/my_backups/clonezilla_backups B2:myclonezillabackups/
exit
```

You will just need to run

```
sudo rclone config
```

Before you do so that the root user has a valid configuration file for rclone. The CLI will not automatically import the configuration file belonging to the user and the terminal will give the following error message:

```
NOTICE: Config file “/root/.config/rclone/rclone.conf” not found — using defaults
```

I used ‘show hidden files’ in my file editor to verify that the Clonezilla image directory did not include any hidden files:

It’s worth looking at the file of the Clonezilla archive in order to estimate how long pushing the backup up to the cloud is going to take:

![](/documentation/images/16.png)

And the using DownloadTimeCalculator.com to estimate how long the process is going to take to run.
Unfortunately because this is a local → cloud backup there are no tricks — like backing up from an EC2 instance — to be relied upon.

![](/documentation/images/17.png)
