`[TOC]`
# pipeline-docker
Pipeline orchestrated by Docker Engine &amp; Docker Compose &amp; Docker Swarm.

#Usage
##git clone
```
git clone git@github.com:open-devops/pipeline-docker
```

##pipeline init
```
cd pipeline-docker; sh pipeline init
```

##pipeline start up
```
sh pipeline up
```

##pipeline status confirmation
```
sh pipeline ps
```

##pipeline stop 
```
sh pipeline stop
```

#external ports
| Type      | Capacity | Port  |
| :-------- | ----------:| :---: |
| ca        | Wekan      |  9090 |
| ca        | Jira      |  9091 |
| scm        | Gitlab      |  9010 |
| scm        | Artifactory      |  9011 |
| cov        | Hygui      |  9088 |
| ci        | Jenkins      |  9080 |
| cq        | Sonarqube      |  9000 |
