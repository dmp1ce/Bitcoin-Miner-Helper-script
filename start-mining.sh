#!/bin/bash
# Script for starting ATI based miners using the Phoenix/poclbm mining combination.

# The first parameter is the Device to user
# The second paremeter is the Host to connect to. The second parameter is optional.


# some vars
user="user"
pass="password"
port="8337"
aggression="12"

# This script needs to be run as root
if [ -z $2 ]; then
  host="MtRed.com"
else
  host=$2
fi

# Make sure this fucking environment variable is set!  It never seems to work for root.  Super annoying!
export LD_LIBRARY_PATH=/opt/ati-stream-sdk-v2.1-lnx64/lib/x86_64/

# Look to see if script is already running
if [[ $(ps -ef) =~ "poclbm DEVICE=$1" ]]; then
  echo "Script with the same command already seems to be running according to 'ps -ef'"
else
  # Script not running so start it.
  echo "Starting python phoenix.py -u http://$user:$pass@$host:$port -v -k poclbm DEVICE=$1 VECTORS AGGRESSION=$aggression"
  cd /opt/miner/phoenix-1.4
  python phoenix.py -u http://$user:$pass@$host:$port -v -k poclbm DEVICE=$1 VECTORS BFI_INT WORKSIZE=128 AGGRESSION=$aggression >> /var/log/mining/mining-gpu-$1.log 2>&1 &
fi
