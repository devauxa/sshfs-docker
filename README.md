# Usage :

* clone this repo
* add a volume : `-v /path/of/this/repos/sshfs-docker:/sshfs-docker`
* change entrypoint : `--entrypoint /sshfs-docker/docker-entrypoint_sshfs.sh`
* add environment : `-e SSHFS_HOSTNAME=8.8.8.8 -e SSHFS_PATH=/srv/data -e SSHFS_USER=data`
* add privilege :  `--privileged=true`

Example :
* docker run -it -v ~/sshfs-docker:/sshfs-docker --entrypoint /sshfs-docker/docker-entrypoint_sshfs.sh -e SSHFS_HOSTNAME=8.8.8.8 -e SSHFS_PATH=/srv/data -e SSHFS_USER=data --privilieged=true ubuntu 
* docker run -d  -v ~/sshfs-docker:/sshfs-docker --entrypoint /sshfs-docker/docker-entrypoint_sshfs.sh -e SSHFS_HOSTNAME=8.8.8.8 -e SSHFS_PATH=/srv/data -e SSHFS_USER=data --privilieged=true ubuntu /docker-entrypoint_other.sh
* ... (see docker-compose_sshfs.sh)
