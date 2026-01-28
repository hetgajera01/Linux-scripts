#!/bin/bash

function clone() {
	if [ -d "django-notes-app" ]; then
		cd django-notes-app
	else
		git clone "https://github.com/LondheShubham153/django-notes-app.git"
	fi
}

function setup() {
	sudo apt update -y
	sudo apt install nginx -y
}
function deploy() {
	docker build -t notes-app . && docker compose up -d   
}

if ! clone; then
	exit 1
fi
setup
deploy
