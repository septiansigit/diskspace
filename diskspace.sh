#!/bin/sh

admin="admin@vincentsigit.com"        
threshold=75

df -PkH | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $6 }' | while read output;
do
        usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1 )
        partition=$(echo $output | awk '{print $2}' )
        if [ $usep -ge $threshold ]; then
        echo "Running out of space \"$partition ($usep%)\" on $(hostname) as on $(date)" |
        mail -s "[ALERT] Out of disk space $usep%" $admin
fi
done

