# checkcompute
Simple script for checking that compute nodes are 100% using the cpu

This script is intended for simple health checking of your compute nodes. 
This can be some servers or clients that are computing for projects like 
SETI@HOME, WCG or maybe CPU Mining for cryptocurrency. The script soley relies
on the fact that uses CPU rather than GPU.

-- Prerequisites
    Access through SSH to the nodes
    SSH keys (preferred without pass) on your nodes

Add IP addresses in the array of your nodes and then run the script:

    ./checkcompute.sh


The ouput could be when all is working like it should be:

[OK] Server 10.0.0.10 (up 433 days) is running with 4 cores
[OK] Server 10.0.0.11 (up 282 days) is running with 24 cores
[OK] Server 10.0.0.12 (up 282 days) is running with 24 cores
[OK] Server 10.0.0.13 (up 9 days) is running with 24 cores

But when something could wrong:

[OK] Server 10.0.0.10 (up 433 days) is running with 4 cores
[OK] Server 10.0.0.11 (up 282 days) is running with 24 cores
[Warning] Server 10.0.0.12 (up 282 days) has a problem, current load is 0.08
[OK] Server 10.0.0.13 (up 9 days) is running with 24 cores

Or even completely down. This is when an email alert is being sent

[OK] Server 10.0.0.10 (up 433 days) is running with 4 cores
[OK] Server 10.0.0.11 (up 282 days) is running with 24 cores
[Warning] Server 10.0.0.12 (up 282 days) has a problem, current load is 0.08
[Failed] Server 10.0.0.13 is down... check it's condition

