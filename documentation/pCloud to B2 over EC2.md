## How To Back Up pCloud to B2 (EC2 + rclone)

To conclude the backup mania for this week, I decided that it would be worthwhile to create a starting snapshot of my pCloud drive on Backblaze B2.

I had to do this somewhat manually because my usual go-to solutions for cloud-to-cloud backups weren’t able to offer much help for this particular use-case. 

Namely:

- Multcloud does not support Backblaze B2 as a storage archive.
- Rclone (at the time of writing) isn’t able to authenticate a pCloud app protected by 2FA (I raised the issue with the team on their GitHub repository today).

Of course, I could have copied pCloud onto my local and then pushed that up to the cloud via rclone (or used Goodsync), but both these approaches would have entailed attempting to upload gigabytes’ worth of data over a 2 Mbps uplink.

So — like the Google Takeout approach I demonstrated a couple of days ago — I chose to improve.

Here’s what did the trick.

## 1. Bundle Your pCloud Files Into an Archive

Firstly, I used the web UI to bundle my pCloud files into an archive for downloading.
To do this, I selected all the folders at the root level.

![](/Documentation/images/21.png)

Then, I clicked on ‘Share Download Link.

And I gave the link a name:

![](/Documentation/images/22.png)

If you loose track of it, you can find all generated download links under ‘Shares’:

![](/documentation/images/23.png)

Copying the link into a browser, I clicked on ‘Download’ and opted for ‘Download as ZIP’:

![](/documentation/images/24.png)

The download began:

![](/documentation/images/25.png)

I went into my download manager and copied the unique download URL. Note: if you just attempt to download the archive directly without sharing the URL will not be unique — and it will not download your file!

![](/documentation/images/26.png)

The URL is formatted like this:

![](/documentation/images/27.png)

The ‘code’ component contains a unique download string.

I started up my EC2 instance and simply ran a ‘wget’ command to download the archive on the remote:

```
wget https://api.pcloud.com/getpubzip?code=24242424
```

![](/documentation/images/28.png)

The download didn’t have a file format, so I renamed it backup080520.zip.

The command is simply:

```
mv getpubzip?code=2424kj3gg2g backup080520.zip
```

To verify that what I downloaded was really the archive I unzipped it, verified that the contents were what I was expecting, and then deleted the extracted files.

Then I simply used a simple rclone sync command to push the backup up to B2.

```
rclone sync backup080520.zip B2:/pcloudbackups
```

With an uploaded speed of over 800 Mbps I pushed my archive up in a couple of minutes.
That’s it!
Don’t forget to delete the backup file on the EC2 machine when you’re done to avoid accruing storage costs (and because there’s no reason to keep it).
