#!/bin/bash
#
# created by bartjan@pc-mania.nl

MAILRECP="johndoe@somedomain.org"
RED="\033[1;31m"
YELLOW="\033[1;33m"
GREEN="\033[1;32m"
RESET="\033[0m"

computehosts=(
	10.0.0.10
	10.0.0.11
	10.0.0.12
	10.0.0.13
	10.0.0.14
	)

echo
for i in ${computehosts[@]}; do
	if nc -w 5 -z "${i}" 22 > /dev/null 2>&1 ; then
		statuscmd=$(ssh ${i} "uptime | sed -n -e 's/^.*average: //p' | cut -d "." -f1")
		numberofcpu=$(ssh ${i} "cat /proc/cpuinfo | grep processor | wc -l")
		miniumcpu=$(($numberofcpu-1))
		uptime=$(ssh ${i} "uptime | cut -d ' ' -f3-5 | sed s/,//g")

		if [[ "$statuscmd" -lt "$miniumcpu" ]]; then
			loadavg=$(ssh ${i} "uptime | sed -n -e 's/^.*average: //p' | cut -d "," -f1")
			echo -e "[${YELLOW}Warning${RESET}] Server ${i} (${uptime}) has a problem, current load is $loadavg"
		else
			echo -e "[${GREEN}OK${RESET}] Server ${i} (${uptime}) is running with $numberofcpu cores"
		fi
	else
		echo -e "[${RED}Failed${RESET}] Server ${i} is down... check it's condition"
		echo -e "[${RED}Failed${RESET}] Server ${i} is down... check it's condition" | mail -s "Server issue ${i}" ${MAILRECP} 
	fi
done
echo	
exit 0

