#!/bin/bash

# Messy, but it works so whatever.

ip_addr=$1
ip_addr_f=${ip_addr//"."/"_"}
name="etcd_$ip_addr_f"

srv_record="    \"1 0 2380 $name.\${var.etcd_domain_name}\""
# Create a user-data file.
cat config/etcd.yml >> _$ip_addr_f\_userdata.yml
template=$(cat templates/_etcd_instance_template| \
  sed -e "s#{{ ip_addr }}#$ip_addr#g" | \
  sed -e "s#{{ ip_addr_f }}#$ip_addr_f#g"| \
  sed -e "s#{{ name }}#$name#g" | \
  sed -e "s#{{ user_data }}#$user_data#g")

# Because of JSON formatting, this is basically a hacky fix.
# first we're going to put our record into the unmodified file.
echo "$srv_record" >> templates/_srv_records

# Then we're going to grab the first half of the file...
cat templates/_etcd_discovery_template > etcd_discovery.tf

# Then we're going to read that record file in as an array 'lines'
IFS=$'\n' read -d '' -r -a lines < templates/_srv_records
for line in "${lines[@]}"
do
  if [[ "$line" == "${lines[-1]}" ]]
  then
    # If we're the last line in the file, then we need to echo without a comma
    echo "$line" >> etcd_discovery.tf
    break
  else
    # If there are more entries to come, then we need a comma at the end of the line.
    echo "$line," >> etcd_discovery.tf
  fi
done

echo "Last line was ${lines[-1]}"

# ... nothing to say here
echo "  ]" >> etcd_discovery.tf
echo "}" >> etcd_discovery.tf

echo "$template" > _$ip_addr_f\_etcd.tf
