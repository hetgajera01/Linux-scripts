#!/bin/bash

read -p "Enter log directory: " log_dir
read -p "Enter archive directory: " archive_dir
read -p "Enter retation day: " re_day
read -p "Enter deletion day: " del_day

if [ ! -d log_dir ]
then   
    echo "$log_dir not found"
fi

if [ ! -d archive_dir ]
then 
    echo "$archive_dir not found, creating .."
    mkdir $archive_dir
fi

find "$log_dir" -maxdepth 1 -name "*.log" -mtime +"$re_day" -exec gzip {} \;

find "$log_dir" -maxdepth 1 -name "*.gz" -exec mv {} "$archive_dir/" \;

find "$archive_dir" -name "*.gz" -mtime +"$del_day" -exec -delete