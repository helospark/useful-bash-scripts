# Small bash script to update your IP for NoIp site (https://www.noip.com).
# You should add it to a cron script, like
# */10 * * * * /path_to_your/no_ip_update.sh
#!/bin/bash

# Change these
username=YOUR_USERNAME
password=YOUR_PASSWORD
host=YOUR_HOST.hopto.org

# Program starts

baseUsernamePassword="$username:$password"
authheader=`echo -n $baseUsernamePassword | base64`

currentIp=`curl https://api.ipify.org/?format=txt`

echo "CurrentIp: $currentIp"

updateResponse=`curl -H "Authorization: Basic $authheader" -H "Host: dynupdate.no-ip.com" http://dynupdate.no-ip.com/nic/update?hostname=$host\&myip=$currentIp`

echo $updateResponse

if [[ $updateResponse == *"nochg"* ]]
then
	# echo "No change in IP" # uncomment for testing
else
  echo "Updated IP, new IP $currentIp";
fi
