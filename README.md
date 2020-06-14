# Master Backup Strategy (V1.3)
By: Daniel Rosehill (github@danielrosehill.co.il)

*Version control:* V1.3 (Documentation updated 06/20)

V1.3 documentation can be viewed and downloaded [here](/documentation/PDF/V13.pdf)

* This "master" backup strategy summarizes the overall backup strategy that I currently use to back up my local and cloud data in compliance with the 3-2-1 backup approach:

* [YouTube explanation (V1.3):](https://www.youtube.com/watch?v=XmJ935hPn64&t=1971s) 

* [Finally, here's a much more simple guide to achieveing 3-2-1 compliant backups](https://www.jwz.org/doc/backups.html). (The advantage to using the method outlined here, however, is that we don't have to keep a disk connected via an enclosure nor do we have to create a cron job as easy as that is. Additionally, we get one more onsite backup.)

![321Backups](/images/master_strategy.png)


## Objective: 3-2-1 Compliant Backups 


**The standard:**

* 3 extant copies of all critical data (primary plus two backups)
* 2 backup copies (on different storage media)
* 1 copy stored off-site

**What's achieved here:**

* This backup strategy achieves 3-2-1 with **one additional onsite backup**. You could think of it as **4** (data source plus three backups) - **3** (backups spread over three different storage media)- **1** (one offsite backup).
* This backup strategy creates an additional onsite backup taken via a different strategy to further diversify the methodologies employed (Timeshift vs. Clonezilla; incremental vs. full image).
* One could improve upon this backup strategy further by adding an additional SDD and syncing via RAID 1. However, this would add **redundancy** (vs. another unnecessary backup). (And remember: redundancy ≠ backups).

<hr>

# 1: Local Backups

![Desktop](/images/desktop_backups.png)

I summarized my approach for backing up my local (Linux) desktop [on LinuxHint.com](https://linuxhint.com/ubuntu_backups_321/).

The components are as follows:

## Local Onsite Backup 1. Via [Timeshift](https://github.com/teejee2008/timeshift) to SSD 2 (automatically, daily)

![Timeshift](/images/timeshift.png)

I take the following restore points:

* Daily (x1)
* Weekly (x1)
* Monthly (x1)

These restore points are saved onto a *dedicated* 480 GB SSD within my desktop. [Timeshift](https://github.com/teejee2008/timeshift) has time and again proven indispensible in rolling the system back to a point in time before changes — typically updates — rendered it unstable or prove some key system like package management. 

Timeshift can be used to restore the system over a CLI.

## Local Onsite Backup 1. Via Clonezilla to SSD 3 (manually, weekly/monthly)

![Clonezilla](/images/clonezilla.png)

**Because Timeshift requires that, at a minimum, GRUB be intact (it is available as a CLI from a Bash environment) it cannot be relied upon to restore a completely bricked Linux system.**

This is the tradeoff between Timeshift (more convenient) and Clonezilla (more reliable) and why this backup approach uses both.

Therefore I also use [Clonezilla](https://www.clonezilla.org) to take disk <-> disk images.

I use another dedicated SSD for this purpose — although there is no reason one couldn't use a very generously sized HDD and create separate partitions for the Clonezilla and Timeshift backups. Using separate storage media for the two backup drives, however, obviously provides a little more protection against disk failure.

I run Clonezilla as often as I remember. Approximately once every 3 months. Worth noting: I have yet to have to rely upon this for restore; rather Timeshift has been enough to roll back to a restore point in the event of any system intsability.


## Local Offsite Backup 1. Via Cloudberry


I use [Cloudberry](https://www.msp360.com/backup/linux/ubuntu.aspx) to create the offsite backups of my Linux machine. I create a job that runs as an incremental backup to a [B2 storage bucket](https://www.backblaze.com/b2/cloud-storage.html).

![](/images/cloudberry.png)

To keep the offsite backup of my local system reasonably well updated I run this job automatically once a week.


## The Deluxe Option. SSD 4 in RAID 1 Configuration (or alternatives)

The benefit to adding the RAID drive (or the alternatives suggested below) would be improved operational continuity in the event of disk failure. Otherwise, in the event of drive failure, a delay would be necessitated while one provisions a new storage medium and executes the restore process. (And worth noting: restoring from Timeshift would be a lengthier process, requiring the prior installation of the OS; restoring from Clonezilla would be quicker, but the restore point would be more historic, thereby risking data loss).

Furthermore, restoring from a backup might be desirable for other reasons (distro update / package that broke dependencies, etc). Therefore it is suggested that an additional RAID disk be *added* to the onsite methods rather than substituted as a replacement for one.

**Disk Failure Protection**

Here are a few ways to protect against disk failure related interruptions to "computing continuity"

* Add more more SDD to this setup and configure in RAID 1 with the main drive. This would be the most elegant approach.
* Have a very barebones Ubuntu installation written to a SDD. Keep this in your file cabinet and have this ready to stick into the computer if your disk fails (so that you can go about buying a new disk and completing the restore process at a time that is convenient to you).
* Have another SSD ready to roll in your cabinet and keep it in its product packaging. Restoring from a Clonezilla image doesn't take that long


## Summary:

| Run Type | Backup Type | Metodology | Frequency | Source | Destination  |
| ---------| ----------- |----------- |---------- |--------| ------------ |
| Automatic | Incremental | [Timeshift](https://github.com/teejee2008/timeshift) | Daily | Primary | Drive 2 (primary x 2) |
| Manual | Full | [Clonezilla](https://www.clonezilla.org) | Monthly | Primary | Drive 3 (primary x 0.5-1) |
| Automatic | Incremental | Cloudberry | Weekly | Primary | Cloud storage |

## Notes:

- Because full system backups capture all virtual machines (VMs) nested within the home directory (if you're using VMWare Workstation player at /home/$user/vmware) there is no need to create separate backups for VMs — although for convenience's sake (to be able to restore a VM without having to restore the overlying system), I take periodic backups of my Windows VM too.
- Because Clonezilla backup images of a whole disk are heavy, I have only ever uploaded backed up to S3 once. In the event of a disk failure and replacement, restoring from local media would make much more sense. 
- This is obviosly desktop-centric. A concerned traveller could bring an external SSD with him/her while travelling with a Clonezilla image of the SSD in order to replace it. 


<hr>

# 2: Cloud Backups: Major 

![MajorCloud](/images/majorclouds.png)

I divide my cloud backup approach into two parts:

* Major cloud buckets
* Minor cloud buckets and SaaS services

The major cloud buckets are so-called because they are heavy and contain a lot of data. For me, these are:

* Cpanels
* Gsuite
* Primary cloud storage device

And these are handled as follows:

## Google Drive (not: Gsuite) + cloud storage --> S3: Via Multcloud (Ongoing, Automated)

![Multcloud](/images/multcloud.png)

I use [Multcloud](https://www.multcloud.com) to automatically sync GDrive and main cloud storage to S3 once a week. 

Because the likelihood of any major cloud provider losing one's data is infintessimally small, I would feel comfortable running these backup syncs less regularly than that. 

## Cpanels (Every 3 months, Manual)

![Hosting](/images/hostingbackup.png)

Every 3 months I manually backup and upload to S3 the websites that I manage.

There's not much more to do than running a full account backup and then uploading and overwriting those files to S3. I haven't managed to get cloud-to-cloud running for these. 

## GSuite (Every 3 months, Manual)

Every 3 months I run a Gsuite Takeout.

Becaues I'm already capturing Google Drive I don't include that in the archive.

I put this up to S3 and keep a copy on a local hard drive too. 

# 3: Cloud Backups: Minor

![MajorCloud](/images/minorclouds.png)


![LI](/images/li.png)

In [this Github repository](https://github.com/danielrosehilljlm/CloudBackupApproaches) I have documented backing up what I call "minor" cloud services and provided instructions for all the providers that I am familiar with — although there are many, many, more. 

Every 3 to 6 months I will manually run through this checklist and upload the backups to S3.

# 4: Pull S3 --> Local (Manual, Every 6 Months)

In order to keep a second copy of the cloud media that is onsite (S3 is clearly another cloud) about once every six months I then pull down my S3 buckets and copy them locally.

I am currenntly doing this onto an external encrypted SSD. I am about to transition over to keeping these backups on a Synology NAS.

Specifically I want to download:

* My hosting backups
* The minor cloud service backups
* The GDrive and Cloud storage backups

I usually save the Gsuite backup not including Gdrive directly onto the local 

# 5: Contact Information

I have certainly invested quite a bit of time in devising this strategy. I am sure that it could be approved upon. However, for the moment it works:

* Since instituting my local backups I have had a stable Linux system for about two years. No more upgrades bricking the system. In fact, Timeshift has all that's been required when an update has corrupted my system.
* I feel much, much more confident putting everything I do on the cloud once I know I have a system for getting a copy. There are things that some people are worried about when using cloud computing that don't worry me. And conversely, I feel a strong need to retain a copy I can control and access of all my cloud data in one place. Others trust their providers' own backup strategies and do not feel the need. We can agree to respect one another's preferences I hope!
* If you would like to get in touch to suggest any improvements please email github at danielrosehill dot co dot il. Thank you for checking out this respository!


