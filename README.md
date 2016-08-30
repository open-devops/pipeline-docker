# pipeline-docker
Pipeline orchestrated by Docker Engine &amp; Docker Compose &amp; Docker Swarm.

#git clone
```
git clone git@github.com:open-devops/pipeline-docker
```

#Preparement
## Step 1: modify localhost to host IP (opendevops_pipeline.env)
PORTAL_LOCALHOST=localhost
->
for example : PORTAL_LOCALHOST=192.168.32.31

## Step 2: setting proxy  (opendevops_pipeline.env)
http_proxy_host=xxxx

## Step 3: setting gitlab ssh config(playbooks/gitlab/inventory)
gitlabserver1 ansible_ssh_host=192.168.32.31 ansible_ssh_user=admin ansible_ssh_pass=123456 ansible_sudo_pass=123456

#pipeline init
```
cd pipeline-docker; sh pipeline init
```

#pipeline start up
for instance : export PORTAL_LOCALHOST=192.168.32.31
```
sh pipeline up
```

#pipeline status confirmation
```
sh pipeline ps
```

#pipeline config
##Preparement
Before execute pipeline config, confirm gitlab container has default  user root with password 5iveL!fe.

#pipeline stop 
```
sh pipeline stop
```

#external ports
| Type      | Capacity | Port  |
| :------------------- | -------------------------:| :---------------: |
| ca        | Wekan      |  9090 |
| ca        | Jira      |  9091 |
| scm        | Gitlab      |  9010 |
| scm        | Artifactory      |  9011 |
| cov        | Hygui      |  9088 |
| ci        | Jenkins      |  9080 |
| cq        | Sonarqube      |  9000 |

