#!/bin/bash

jssUrl=
jamfUser=
jamfPass=
id=

#check if enable or disabled Automatically Force App Updates for specific App ID
appUpdate=$(curl -sku ${jamfUser}:${jamfPass} -H "Accept: application/xml" ${jssUrl}/JSSResource/mobiledeviceapplications/id/${id} | xpath "/mobile_device_application/general/keep_app_updated_on_devices/text()") 

echo $appUpdate

#disable or enable Automatically Force App Updates by changing to: false or true
curl -sku ${jamfUser}:${jamfPass} -H "Content-type: application/xml" ${jssUrl}/JSSResource/mobiledeviceapplications/id/${id} -X PUT -d "<mobile_device_application><general><keep_app_updated_on_devices>false</keep_app_updated_on_devices></general></mobile_device_application>" 
 

exit 0