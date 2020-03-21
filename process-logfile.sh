#!/bin/bash

#date --date="Dec 20 20:25:09" "+%s"
#ls -1 | while read line ; do echo $line ; done
INPUT="$1"

declare -A device_table

function create_device_lookup_table (){
lines=`lshw -c disk | grep "logical name" | grep -o "/dev/.*"`
while read line ; do
  device_logical=$line
  device_id=`udevadm info --query=all --name="$device_logical" | grep ID_SERIAL_SHORT | sed -E "s/.*ID_SERIAL_SHORT=(.+)/\\1/"`
  device_table[$device_logical]="$device_id"
done <<< "$lines"
}

function parse_logs () {

grep -a -i "SMART.*attribute.*changed.*" "$INPUT" | cut -d" " -f"1 2 3 7 13 16 18" | while read line ; do
  IFS=-' ' read f1 f2 f3 f4 f5 f6 f7 <<< "$line"
  timestamp=`date --date="$f1 $f2 $f3" "+%s"`
  if [ -n "$timestamp" ]; then
    device_logical="$f4"
    device_id=${device_table[$device_logical]}
    attribute="$f5"
    old_value="$f6"
    new_value="$f7"
    echo $timestamp,\"$device_logical\",\"$device_id\",\"$attribute\",$old_value,$new_value
  fi
done
}

create_device_lookup_table

parse_logs | sort | uniq

