# pipeline-docker
Pipeline orchestrated by Docker Engine &amp; Docker Compose &amp; Docker Swarm.

#git clone
git clone git@github.com:open-devops/pipeline-docker

#pipeline init
cd pipeline-docker; sh pipeline init

#pipeline start up
sh pipeline up

#pipeline status confirmation
sh pipeline ps

#pipeline stop 
sh pipeline stop

#external ports
ca: wekan:9090
ca: jira :9091

scm:gitlab:9010
scm:artifactory:9011

cov:hygui:9088


ci:jenkins:9080

cq:sonarqube:9000
