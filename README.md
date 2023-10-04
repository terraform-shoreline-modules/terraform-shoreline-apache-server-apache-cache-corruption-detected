
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Apache Cache Corruption Detected
---

This incident type typically refers to a situation where the Apache cache is found to have been corrupted or damaged. The Apache cache is used to store frequently accessed information in order to speed up the delivery of content to visitors. When the cache becomes corrupted, it can cause errors or issues with the website or application that relies on it. This type of incident may require investigation and remediation in order to restore the cache and ensure that the website or application is functioning properly.

### Parameters
```shell
export APACHE_CACHE_DIRECTORY="PLACEHOLDER"

export DISK_NAME="PLACEHOLDER"

export PATH_TO_CACHE_DIRECTORY="PLACEHOLDER"

export PATH_TO_APACHE_CLEAN="PLACEHOLDER"
```

## Debug

### Check Apache's error log for any relevant messages
```shell
tail -n 50 /var/log/apache2/error.log
```

### Check the Apache cache directory for any signs of corruption
```shell
ls -la ${APACHE_CACHE_DIRECTORY}
```

### Check if Apache is running
```shell
systemctl status apache2
```

### Restart Apache to see if it resolves the issue
```shell
systemctl restart apache2
```

### Check the Apache cache size to see if it's larger than expected
```shell
du -sh ${APACHE_CACHE_DIRECTORY}
```

### Check the system's memory usage to see if it's causing any issues with the cache
```shell
free -m
```

### Check if there are any read or write errors on the disk where the cache is stored
```shell
dmesg | grep ${DISK_NAME}
```

### Check the system's disk usage to see if it's causing any issues with the cache
```shell
df -h
```

## Repair

### Restart Apache server: One of the easiest ways to resolve this issue is to restart the Apache server. This will flush the cache and start with a fresh cache.
```shell


#!/bin/bash



# Stop Apache server

sudo service apache2 stop



# Start Apache server

sudo service apache2 start


```

### Clear the Cache: Clearing the cache manually can also help resolve the issue. The cache can be cleared by deleting the cache files manually or using a tool like Apache clean.
```shell


#!/bin/bash



# Set the path to the Apache cache directory

cache_dir=${PATH_TO_CACHE_DIRECTORY}



# Delete all files in the cache directory

rm -rf $cache_dir/*



# Use Apache clean to clear the cache (optional)

# apache_clean ${PATH_TO_APACHE_CLEAN}



# Restart the Apache server

service apache2 restart


```