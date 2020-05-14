#!/bin/bash

rclone sync -v ~/config/autokey B2:/linuxmiscbackups/
rclone sync -v ~/.config/openbox B2:/linuxmiscbackups/
rclone sync -v ~/.config/libreoffice B2:/linuxmiscbackups/
rclone sync -v ~/.config/screenlayouts B2:/linuxmiscbackups/
rclone sync -v ~/Scripts B2:/linuxmiscbackups/
