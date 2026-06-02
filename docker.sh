#!/bin/bash

exited_container=$(docker -a -q -f status=exited)

if [ -n "$exited_container" ]then
    docker rm $exited_container

#to remove unused docker resource
docker system prune -f

#to remove unused volume
docker volume prune -f