#!/bin/bash

rclone sync -v ~/config/autokey B2:/mylinuxbackups
rclone sync -v ~/.config/openbox  B2:/mylinuxbackups
rclone sync -v ~/.config/libreoffice  B2:/mylinuxbackups
rclone sync -v ~/.config/screenlayouts  B2:/mylinuxbackups
rclone sync -v ~/Scripts  B2:/mylinuxbackups
