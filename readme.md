# collectd-unbound

Simple shell script to collect stats from unbound-control and forward them to collectd.
Intended to use on an openwrt device on any other small device that can not deal with the overhead of go or python to collect the statistics. To avoid complexity and reduce computation time the script relies a lot on hard-coded conventions.

For Visualisation of the collected data luci-statistics together with the Output plugin RRDTool is used.

# Config
None

# Install

## Prequisites

Designed to work on a openwrt device you need the packages busybox, collectd, collectd-mod-exec, unbound, unbound-control, luci-app-statistics installed for this script to work meaningfully.
Luci-statistics assumes you use RRD as a backend for collectd.

`opkg update && opkg install busybox collectd collectd-mod-exec unbound unbound-control luci-app-statistics bash`

## Install collectd-unbound

1. Copy the files to the desired destinations on your openwrt.

    `scp opt/user/bin/collectd-unbound.sh root@<your-server-ip>:/opt/user/bin/collectd-unbound.sh`

    `scp www/luci-static/resources/statistics/rrdtool/definitions/unbound.js root@<your-server-ip>:/www/luci-static/resources/statistics/rrdtool/definitions/unbound.js`

2. Do not forget to make collectd-unbound.sh executable.

    `chmod +x /opt/user/bin/collectd-unbound.sh`

3. In order to start collecting you need to create a collectd-exec task and execute `/opt/user/bin/collectd-unbound.sh` as user unbound.
