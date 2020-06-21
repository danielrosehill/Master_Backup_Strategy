## Clonezilla over LAN

In order to create a disk image from a host over LAN to a Synology NAS:

![](/images/lan_clonezilla1.png)

**Important**: When you arrive at this screen, you need to change from the default mount point of /home/partimag. Unlike when using a local drive as the target, the NAS needs to see a real target directory in order to allow the SSH connection to authenticate. It will not allow the creation of a temporary mount point to save the backup. I created a shared network drive called simply 'Clonezilla' before beginning this process, so entered `/Clonezilla` in the input field here. If you do not do this, the authentication will not proceed and you won't be able to create the backup. (It took several failed attempts for me to figure this out!)

* 1/ Select SSH server as the Clonezilla image directory.

* 2/ For mount sshfs, "the directory where Clonezilla image will be saved to or read from": You need to change this from the default (/home/partimag) to an actual volume that exists on the target (unlike when choosing a local drive as the restore point). I created a shared volume called 'Clonezilla' before running this so was simply able to choose /Clonezilla as the point to mount the backup directory. Remember that the images will be encased within a named folder, so this shouldn't be unique to this particular image.

* 3/ Accept the SSH server's fingerprint.

The backup will now run.

Make sure, before initiating, that the user account has SSH access and read/write access to the target directory / home/partimage mount point. Otherwise, the authentication will choke the process from continuing.
