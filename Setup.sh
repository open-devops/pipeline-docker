#!/bin/sh

set -e

date
echo "## Preparement: pull the docker images from docker hub"
echo "#  Image: base"
docker pull devopsopen/docker-base
echo
echo "#  Image: jenkins"
docker pull devopsopen/docker-ci-jenkins       
echo
echo "#  Image: hygieia api"
docker pull devopsopen/docker-cov-hyapi        
echo
echo "#  Image: mongodb"
docker pull devopsopen/docker-com-mongo        
echo
echo "#  Image: sonarqube"
docker pull devopsopen/docker-cq-sonarqube     
echo
echo "#  Image: hygieia UI"
docker pull devopsopen/docker-cov-hygui        
echo
echo "#  Image: wekan"
docker pull devopsopen/docker-ca-wekan       
echo
echo "#  Image: jira"
docker pull devopsopen/docker-ca-jira       
echo
echo "#  Image: artifactory"
docker pull devopsopen/docker-scm-artifactory  
echo
echo "#  Image: gitlab"
docker pull devopsopen/docker-scm-gitlab       
echo
echo "## Preparement Complete."
date

echo "## Docker-Compose up"
docker-compose up
