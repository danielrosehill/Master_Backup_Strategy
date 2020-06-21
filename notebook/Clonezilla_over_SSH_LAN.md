## Clonezilla over LAN

In order to create a disk image from a host over LAN to a Synology NAS:

!([](/images/lan_clonezilla1.png)

* 1/ Select SSH server as the Clonezilla image directory.

* 2/ For mount sshfs, "the directory where Clonezilla image will be saved to or read from": You need to change this from the default (/home/partimag) to an actual volume that exists on the target (unlike when choosing a local drive as the restore point). I created a shared volume called 'Clonezilla' before running this so was simply able to choose /Clonezilla as the point to mount the backup directory. Remember that the images will be encased within a named folder, so this shouldn't be unique to this particular image.

* 3/ Accept the SSH server's fingerprint.

The backup will now run.

Make sure, before initiating, that the user account has SSH access and read/write access to the target directory / home/partimage mount point. Otherwise, the authentication will choke the process from continuing.
