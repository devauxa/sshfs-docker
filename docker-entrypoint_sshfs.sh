#!/bin/bash

# Check if sshfs exists
path=`whereis sshfs |cut -d' ' -f 2 |grep -v ":"`
if [ -z "$path" ];
then
    if [ "$EUID" -ne 0 ]
    then echo "Please run as root"
        exit
    fi
    # Install sshfs
    apt-get update && apt-get install -y sshfs && apt-get clean && rm -rf /var/lib/apt/lists/*
fi

# Create your path sshfs
mkdir -p $SSHFS_PATH

# Init perm ssh key
mkdir -p ~/.ssh
cp /sshfs-docker/ssh_key/id_rsa_docker ~/.ssh/id_rsa
cp /sshfs-docker/ssh_key/known_hosts ~/.ssh/known_hosts
chmod 600 ~/.ssh/id_rsa
chmod 700 ~/.ssh

# Start sshfs
sshfs -o IdentityFile=~/.ssh/id_rsa $SSHFS_USER@$SSHFS_HOSTNAME:$SSHFS_PATH $SSHFS_PATH

# Set your command here (example)
# python /path/my_powerfull_script.py $*
# exit

# Try to use your args for running docker
if [ -f "$1" ]; then
    echo "SSHFS> [INFO] Running with your arg"
    $*
    exit
fi

# Check if docker-entrypoint.sh exist
if [ ! -f "/docker-entrypoint.sh" ]; then
    echo "SSHFS> [WARN] Please, add your docker-entrypoint.sh in /"
    echo "              or change $PWD/docker-entrypoint_sshfs.sh"
    echo "              or use bash $*"
    /bin/bash $*
else
    echo "SSHFS> [INFO] docker-entrypoint found in /"
    echo "              start"
    /docker-entrypoint.sh $*
fi
