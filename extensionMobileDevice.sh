#!/bin/bash 

# Created 19/12/2018 by robokopo
# Update extension attribute value for mobile device


jssUrl="https://pkopocz.jamfcloud.com"
jamfUser="api"
jamfPass="api"
device_id="8"

#Values for extension attribue
ext_id="1"
ext_name="Device Type"
ext_type="String"
ext_value="Type 1"


extensionBefore=$(curl -sku ${jamfUser}:${jamfPass} -H "Accept: application/xml" ${jssUrl}/JSSResource/mobiledevices/id/${device_id} | xpath "/mobile_device/extension_attributes/extension_attribute[1]/value/text()") 

echo $extensionBefore

curl -ksu ${jamfUser}:${jamfPass} ${jssUrl}/JSSResource/mobiledevices/id/${device_id}/subset/extension_attributes -H "Content-type: application/xml" -X PUT -d "<mobile_device><extension_attributes><extension_attribute><id>${ext_id}</id><name>${ext_name}</name><type>${ext_type}</type><value>${ext_value}</value></extension_attribute></extension_attributes></mobile_device>"

extensionAfter=$(curl -sku ${jamfUser}:${jamfPass} -H "Accept: application/xml" ${jssUrl}/JSSResource/mobiledevices/id/${device_id} | xpath "/mobile_device/extension_attributes/extension_attribute[1]/value/text()") 

echo $extensionAfter

exit 0

