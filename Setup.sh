#!/bin/sh

set -e

TEMP_LOG_FILE=/tmp/pipeline_devops_docker.log.$$

pull_docker_image(){
  image_name="$1"
  echo "#   Image: ${image_name}"
  docker images |grep ${image_name} 2>/dev/null
  if [ $? -ne 0 ]; then
    docker pull ${image_name}
  fi
  echo
}

capability_mgnt(){
  action="$1"
  capa="$2"
  port="$3"
  SLEEP_TIME=3

  echo "## ${capa} ${port}: ${action} begins ..."
  docker-compose ${action} ${capa} >>$TEMP_LOG_FILE 2>&1 &
  sleep 3
  echo "## ${capa} ${port}: ${action} end    ..."
  echo
}

date
echo "## pipeline init ..."
for image in base ci-jenkins hyapi mongo sonarqube hygui wekan jira artifactory gitlab
do
  pull_docker_image devopsopen/docker-${image}
done
date

echo "## pipeline up "
capability_mgnt up mongo 27017
capability_mgnt up cap_scm 9010
capability_mgnt up artifactory 9011
capability_mgnt up cap_ca 9090
capability_mgnt up jira 9091
capability_mgnt up hyapi 8080
capability_mgnt up hygui 9088
capability_mgnt up cap_ci 9080
capability_mgnt up cap_cq 9092

echo "## pipeline ps "
docker-compose ps
echo

echo "## confirm log result: ${TEMP_LOG_FILE}"
