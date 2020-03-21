# smartmon-report
Create visual reports of hard disk SMART attribute changes over time.

# How to use

`sudo ./create-report.sh`

will write the report into a random directory under `/tmp`. The directory path is written to stdout as the last line.
The csv report can be imported with openoffice or libreoffice and plotted as a chart.

# Prerequisites & assumptions
- [smartmontools](https://www.smartmontools.org/) are installed
- smartd logs into /var/log/syslog
- /tmp is what it usually is
- Ubuntu 18.04

# Knows bugs
Logs don't contain the year, so each log entry is assumed to belong to the current year. This will be in most cases _not_ correct
as log archives in `/var/log/syslog*` usually date several months past.
