# Master Backup Strategy
By: Daniel Rosehill (github@danielrosehill.co.il)

This "master" backup strategy summarizes the overall backup strategy that I currently use to back up my local and cloud data in compliance with the 3-2-1 backup approach:

## Objective: 3-2-1 Compliant Backups 

* 3 extant copies of all critical data
* 2 backup copies
-> Copies on different storage media
* 1 copy stored off-site

<hr>

# 1: Local Backups

I summarized my approach for backing up my local (Linux) desktop [on LinuxHint.com](https://linuxhint.com/ubuntu_backups_321/).

The components are as follows:

## 1. Timesfhit backup

![Timeshift](/images/timeshift.png)

I take the following restore points:

* Daily (x1)
* Weekly (x1)
* Monthly

These restore points are saved onto a *dedicated* 480 GB SSD within my desktop. [Timeshift](https://github.com/teejee2008/timeshift) has time and again proven indispensible in rolling the system back to a point in time before changes — typically updates — rendered it unstable or prove some key system like package management. 

Timeshift can be used to restore the system over a CLI.

## 2. Clonezilla

![Clonezilla](/images/clonezilla.png)

Because Timeshift requires that GRUB be intact, it cannot be relied upon to restore a completely bricked Linux system.

Therefore I also use [Clonezilla](https://www.clonezilla.org) to take disk <-> disk images.

I use another dedicated SSD for this purpose — although there is no reason one couldn't use a very generously sized HDD and create separate partitions for the Clonezilla and Timeshift backups (although this creates more redundancy on storage media). 

I run Clonezilla as often as I remember. Approximately once every 3 months. I have yet to have to rely upon this for restore.

## Notes:

- Because full system backups capture all virtual machines (VMs) nested within the home directory (if you're using VMWare Workstation player at /home/$user/vmware) there is no need to create separate backups for VMs — although for convenience's sake (to be able to restore a VM without having to restore the overlying system), I take periodic backups of my Windows VM too.
