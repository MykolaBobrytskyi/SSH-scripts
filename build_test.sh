#!/bin/bash
cd /home/docker_data
initial_timestamp=$(sudo docker-compose exec smt rake maintenance:status)
trim() {
    local var="$*"
    # remove leading whitespace characters
    var="${var#"${var%%[![:space:]]*}"}"
    # remove trailing whitespace characters
    var="${var%"${var##*[![:space:]]}"}"
    echo -n "$var"
}

timestamp=$(trim "$initial_timestamp")

if [ $timestamp == "false" ]; then
    echo "timestamp is false, exitin";
    exit 0
fi

if  (( ${#timestamp} != 10 )); then
    echo "timestamp var is $timestamp and doesn't seem to be an actual timestamp, exiting";
    exit 0
fi

[ -e /home/user/.maintenance-started ] && echo "File exists" || > /home/user/.maintenance-started

echo "var fileTimestamp = $timestamp;" | sudo tee /home/user/docker_data/np/maintenance_page/targettime.js
