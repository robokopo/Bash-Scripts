#!/bin/bash

# Created 9/11/2018 by robokopo
# Purpose of this script is to disable or enable option to force mobile device apps updates in Jamf Pro

jssUrl=
jamfUser=
jamfPass=
#id of mobile device App
id=
#true or false
forceUpdate=

#check if enable or disabled Automatically Force App Updates for specific App ID
appUpdate=$(curl -sku ${jamfUser}:${jamfPass} -H "Accept: application/xml" ${jssUrl}/JSSResource/mobiledeviceapplications/id/${id} | xpath "/mobile_device_application/general/keep_app_updated_on_devices/text()") 

echo $appUpdate

#disable or enable Automatically Force App Updates by changing to: false or true
curl -sku ${jamfUser}:${jamfPass} -H "Content-type: application/xml" ${jssUrl}/JSSResource/mobiledeviceapplications/id/${id} -X PUT -d "<mobile_device_application><general><keep_app_updated_on_devices>${forceUpdate}</keep_app_updated_on_devices></general></mobile_device_application>" 
 

exit 0