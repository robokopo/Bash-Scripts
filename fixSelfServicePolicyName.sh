#!/bin/bash 

# Created 9/11/2018 by robokopo
# Purpose of this script is to update Self Service policy name if it's missing

jssUrl= 
jamfUser= 
jamfPass= 

# Policies ID's to update
ArreypolicyId=(2 5 7 8 9 10 11 12 13 15 16 17 19 20) 

for i in ${ArreypolicyId[@]} 
	do 
		policyName=$(curl -sku ${jamfUser}:${jamfPass} -H "Accept: application/xml" ${jssUrl}/JSSResource/policies/id/${i} | xpath "/policy/general/name/text()") 
if [[ ! -z ${policyName} ]]; then 
	curl -sku ${jamfUser}:${jamfPass} -H "Content-type: application/xml" ${jssUrl}/JSSResource/policies/id/${i} -X PUT -d "<policy><self_service><self_service_display_name>${policyName}</self_service_display_name></self_service></policy>" 
else 
	echo "Policy with id -${i}- not found or something went wrong" 
fi 
done

exit 0