#!/bin/bash

# Created by robokopo
# Disable Safari Extenstions for current user

currentuser=$(/bin/ls -la /dev/console | /usr/bin/cut -d ' ' -f 4)
su -l $currentuser -c "defaults write com.apple.Safari ExtensionsEnabled 0"

exit 0