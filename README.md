# CentOS-server-configuration
This is a puppet module packet for the configuration of a Centos7 operating system. The system is intended for ssh/sshfs connectivity, ZFS file system and Plex media server.
The test system for the server was Centos7 (el-7.4) minimal  64bit installation with a standard security configuration. 

There is also a module for debian based operationgsystem for sshfs folder mounting.
The test system for the sshfs client was Linux mint (18) 64bit installation with standard mate desktop.

For this work puppet version 3.8.5 was used. This will work with newer puppet versions, but note that the master server
must be higher or equal version compared to slaves.

This is the final work for the course palvelinten hallinta, teached by Tero karvinen. 
http://terokarvinen.com/2017/aikataulu-palvelinten-hallinta-ict4tn022-3-5-op-uusi-ops-loppusyksy-2017-p5 

The modules are intended to be installed in a puppet master-slave architecture.
Modules intended for nodes are to be included in the site.pp file on the master computer.
Include all the modules, expept the linux mint module for the server installation.
For the sshfs client installation include the linux mint and ssh modules.

These modules need to be modified for user purposes,
instructions for each module are commented in the modules init.pp file.

Instructions for puppet installation for different operating systems can be found in the puppet manual:
https://docs.puppet.com/puppet/3.8/install_el.html
https://docs.puppet.com/puppet/3.8/install_debian_ubuntu.html
