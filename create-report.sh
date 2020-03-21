#!/bin/bash

dir="/tmp/smartmon-$(uuidgen)"
report="$dir/smartmon-report.csv"
mkdir "$dir"
gunzip -c /var/log/syslog.*.gz > "$dir/syslog"
cat /var/log/syslog.? var/log/syslog.1 /var/log/syslog >> "$dir/syslog"

echo "\"Timestamp\",\"Device\",\"ID\",\"Attribute\",\"Old value\",\"New value\"" > "$report"
./process-logfile.sh "$dir/syslog" >> "$report"

echo Writing report to "$report"
