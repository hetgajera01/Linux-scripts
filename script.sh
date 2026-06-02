#!/bin/bash

TIMESTAMP=$(date "+%Y-%m-%d_%H-%M-%S")

read -p "Enter source directory: " source_dir 
read -p "Enter backup_directory: " backup_dir

#echo "$TIMESTAMP"

if [ ! -d ${source_dir} ];
then
     echo "Directory not exists."
     exit 1
fi


if [ ! -d ${backup_dir} ];
then
    echo "Creating backup directory.."
    mkdir -p ${backup_dir}
    
    if [ $(?) -ne 0 ] 
    then
        echo "Failed to create directory"
        exit 2
    
    fi
fi

sudo zip -r "$backup_dir/backup_$TIMESTAMP.zip" "$source_dir" > /dev/null

if [ ! ${?} -eq 0 ] 
then 
    echo "Failed to zip"
    exit 3
fi

find "$backup_dir" -type f -name "backup_*.zip" -mtime +30 -delete

exit 0