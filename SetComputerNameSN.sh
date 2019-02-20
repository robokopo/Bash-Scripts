#!/bin/bash

serialNumber=$(ioreg -c IOPlatformExpertDevice -d 2 | awk -F\" '/IOPlatformSerialNumber/{print $(NF-1)}')

sudo scutil --set HostName ${serialNumber}
sudo scutil --set LocalHostName ${serialNumber}
sudo scutil --set ComputerName ${serialNumber}
dscacheutil -flushcache

exit 0
