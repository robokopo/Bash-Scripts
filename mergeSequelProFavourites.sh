#!/bin/bash

# Created by robokopo
# Script created during Jamf Expert to merge Sequel Pro plist with list of favourites services

currentuser=$(ls -l /dev/console | /usr/bin/awk '{print $3}')
basePlist="/Users/${currentuser}/Library/Application Support/Sequel Pro/Data/Favorites.plist"
jamfproPlist="/tmp/jps.plist"

/usr/libexec/PlistBuddy -x -c "Merge $jamfproPlist 'Favorites Root:Children'" "$basePlist"

exit 0