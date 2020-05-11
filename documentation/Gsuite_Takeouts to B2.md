## Gsuite to B2 (rclone + EC2)

In order to finish up my cloud backups last week, I wanted to move a copy of my G Suite storage to another cloud location.

There was only one problem:

My full Google Takeout was about 50 GB in size.

My residential internet connection has an average upload speed

![](/documentation/images/31.png)

Putting those two numbers together things were not looking good. Putting those two numbers together yielded this result:

![](/documentation/images/32.png)

Therefore, the only viable solution was to go cloud-to-cloud.

Looking at the C2C backup space there are many interesting providers on the market like Skyvia, Datto, Multcloud, Barracuda and more — but finding a solution that would capture an entire Google Takeout (versus a G Suite export that focused only on key data like email) and then move it up to Backblaze B2 was proving an uphill struggle.

So — putting together a few rudimentary tools — I decided to do things the DIY way. Here’s how.

## 1. Run a Google Takeout

Firstly, run a Google Takeout to capture all your data from Google.

My whole idea here was to have my whole G Suite user data in another cloud repository.

So I chose to take out every service that I could.

That added about 20 GB worth of YouTube videos. If you want to pull out a lighter archive, you can exclude services — but then, of course, it won’t be a complete backup.

![](/documentation/images/33.png)

## 2. Get Everything Ready on the B2 Side
Of course, you should also have everything ready to go on your destination — which in this case is Backblaze B2.
As I was backing up to Backblaze B2 I configured an access key for rclone on EC2 and a bucket.

![](/documentation/images/34.png)

And creating the key:

![](/documentation/images/35.png)

## 3. Spin up an EC2 Instance With a Desktop Environment

In AWS, you’ll want to create an instance that you can get a GUI / desktop environment with easily.
I simply searched the Amazon Machine Image (AMI) library for ‘desktop’

![](/documentation/images/36.png)

This template running Amazon Linux is fine:

![](/documentation/images/37.png)

Make sure you select an instance type that’s going to have enough storage to hold your Takeouts after you download them and before you upload.
My Takeout came to about 50 GB so I went for an instance with 75 GB to leave a little bit of room for the operating system:

![](/documentation/images/38.png)

Launch your instance.

## 4. Start the Server, Set up VNC Server and Rclone

Go get a graphical user interface (GUI) so that we can just download our Takeouts from the Gsuite interface we need to install a GUI.
Firstly, download the .pem key file and then SSH into the EC2 instance.

As this machine already came with one installed, we simply need to run:

```
vncserver :1
```

in a terminal

In order to start running the VNC server.

After installing tinyvnc on the computer we are connecting from, and after copying the .pem file into a local directory we then need to run this command — replacing PEM_FILE with the location of our file of course we need to create an SSH connection to establish the VNC tunnel:

```
ssh -L 5901:localhost:5901 -i PEM_FILE ec2-user@INSTANCE_IP
```

You should now be able to log in to a VNC view of your EC2 desktop:

![](/documentation/images/39.png)

## 5. Download Your Google Takeout

Next, in your EC2 machine, download your Google Takeout.

If we were simply moving over a Gdrive, we could do this totally cloud to cloud through rclone.

In fact, we could run the backup far more conveniently from a local machine.

But because we’re moving a Takeout up to B2 we need an actual web browser — hence the GUI and our choice of instance type.

To do this navigate to the Google Takeout and select the export that you need:

![](/documentation/images/310.png)

Download your files directly onto the EC2 instance:


![](/documentation/images/311.png)

The instance should have a fast connection — almost certainly faster than what you have at home — so this shouldn’t take too long.

While you’re doing that you might want to see how fast the line on your instance is.

Here’s what I got:

![](/documentation/images/312.png)

That’s almost 300 times the upload speed of my home connection!

## 6. Configure Rclone
The rest is pretty straightforward.
Install the rclone command line interface (CLI):

![](/documentation/images/313.png)

That’s:
```
sudo yum install rclone
```
Then start the configuration process by entering:
```
rclone config
```
The CLI will guide through the installation steps. You simply need to select the storage type and input the access key you created in B2:

![](/documentation/images/314.png)

Finally, it’s time to run the big command!

With your Takeout archives in the folder you want them to be in you can simply run a sync to push them up to B2. If you’re pushing a large Takeout across the wire adding the verbosity (-v) operator is useful to assess progress. You can add up to three levels (-vvv) to increase the detail produced.

```
rclone -v sync takeouts/ B2:/yourbucket

![](/documentation/images/315.png)
```

Sit back and observe:

I moved about 50 GB of data up to the cloud in roughly 30 minutes — as opposed to the time estimate of almost 3 days (running 24/7) had I chosen to run it from my local area network. So cloud backups can definitely save time and frustration.

Use the web UI to double check that the files have uploaded as expected:

![](/documentation/images/316.png)

And that’s it!
Follow these steps to back your G Suite Takeouts up to B2!


