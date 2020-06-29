#!/bin/bash

## Filesystem backup

rsync -arvz -e 'ssh -p 12345' --delete --progress myuser@123.456.789.10:/home/mycpaneluser/public_html /home/me/backups/hosting/mysite/files/

## MySQL backup

rsync -arvz -e 'ssh -p 12345' --delete --progress myuser@123.456.789.10:/home/mycpaneluser/backup /home/me/backups/hosting/mysite/mysql/

exit

