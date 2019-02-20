#!/bin/bash


SUCCESS=0
domain=apple.com
needle=locate.$domain
hostline="17.171.120.82 $needle"
filename=/etc/hosts

# Determine if the line already exists in /etc/hosts
grep -q "$needle" "$filename"  # -q is for quiet. Shhh...

# Grep's return error code can then be checked. No error=success
if [ $? -eq $SUCCESS ]
then
	echo "Domain already exists. Exiting..."
	exit 0;
else
	# If the line wasn't found, add it using an echo append >>
	echo "$hostline" >> "$filename"
		# Let's recheck to be sure it was added.
		grep -q "$needle" "$filename"

		if [ $? -eq $SUCCESS ]
				then
						exit 0;
				else
						exit 1;
		fi
fi

exit 0