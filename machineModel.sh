#!/bin/sh

machineModel=$(curl -s https://support-sp.apple.com/sp/product?cc=`system_profiler SPHardwareDataType | awk '/Serial/ {print $4}' | cut -c 9-` |
		sed 's|.*<configCode>\(.*\)</configCode>.*|\1|')

echo "<result>${machineModel}</result>"

exit 0