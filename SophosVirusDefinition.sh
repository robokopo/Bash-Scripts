#!/bin/sh

if [ -f "/usr/local/bin/sweep" ]; then
result=$(/bin/date -j -f "%b %d %Y" "$(/usr/local/bin/sweep -v | grep "Released" | awk '{print $4, $3, $5}')" "+%Y-%m-%d %H:%M:%S")
echo "<result>${result}</result>"
else
echo "<result>Not installed</result>"
fi