#! /bin/bash

if [ "$#" -eq 0 ]; then
   echo "Usage: $0 <remote hostname/IP>"
   exit 1
fi

if [ "$1" == "config" ] ; then

   # Update the pi
   sudo apt-get update
   sudo apt-get upgrade -y

   # Other package installs here
   echo sudo apt-get install random_packages

   # Create user with same username as user that invoked the script
   sudo useradd -m $2

   # Copy the ssh key from the pi user
   sudo su $2 -c "mkdir -p ~/.ssh && chmod 700 ~/.ssh"
   grep $2 ~/.ssh/authorized_keys | sudo su $2 -c "cat > ~$2/.ssh/authorized_keys"
   sudo su $2 -c "chmod 600 ~/.ssh/*"

   # Set the new user's password
   sudo passwd $2

   # Delete this script before rebooting
   rm -f $0
   sudo reboot

else 
   # Add the pi to the local host's known_hosts file to prevent prompting
   ssh-keyscan -t rsa $1 >> ~/.ssh/known_hosts

   # remove duplicate keys from the known_hosts file else it gets rather messy
   sort -u ~/.ssh/known_hosts > ~/temp_known_hosts && mv -f ~/temp_known_hosts ~/.ssh/known_hosts

   # install the SSH keys on the pi
   sshpass -p raspberry ssh-copy-id pi@$1

   # Copy this script over to the pi (we can now use ssh keys)
   scp $0 pi@$1:~/

   # Invoke the config script (copy of this file) on the pi with parameter 'config'
   ssh pi@$1 "./`basename "$0"` config $USER"
fi
