#! /bin/bash

set -euo pipefail

# Grab environment variables
. ./.env

# Remove sample project
echo "Removing the sample project..."
bin/remove-sample.sh

echo "Creating new Django Rest Framework Project Scaffold..."
echo "This will take some time."
echo "It will start a server when it is done."
echo "Type 'CTRL-C' after it starts the server."
sleep 15
docker-compose -f onestep-docker-compose.yml up --build

CONTAINER_NAME=`docker-compose -f onestep-docker-compose.yml ps | grep api | sed 's; .*$;;'`
echo "Container name is ${CONTAINER_NAME}"
echo "Copying code from the container"
docker cp ${CONTAINER_NAME}:/code/manage.py .
docker cp ${CONTAINER_NAME}:/code/api .
docker cp ${CONTAINER_NAME}:/code/staticfiles .
docker cp ${CONTAINER_NAME}:/code/$PROJECT_NAME .

# fix ownership
echo "Fixing ownership on Linux"
if [ `uname -s` = "Linux" ]
then
  ls --color=auto -Altr
  echo "sudo chown -R `id -u $USER`:`id -g $USER` ."
  sudo chown -R `id -u $USER`:`id -g $USER` .
  ls --color=auto -Altr
fi

echo "Finished"
