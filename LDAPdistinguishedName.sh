#!/bin/sh

# Extension attribute for Jamf Pro to get distinguishedName from LDAP based on machine name

#LDAP domain
LDAP=EMEIA-LDAP01

CompName=$(dsconfigad -show | awk '/Computer Account/{print $NF}' | sed 's/$$//')

distinguishedName=$(dscl "/Active Directory/${LDAP}/All Domains" read /Computers/${CompName}$ dsAttrTypeNative:distinguishedName | tail -1 | awk -F ':' '{print $3}')

echo "<result>${distinguishedName}</result>"

exit 0
