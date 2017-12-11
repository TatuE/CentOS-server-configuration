class linuxmint {

	# this module is not mandatory in the centos7 server configuration. Its function is to create a sshfs folder mount to a remote client, from the centos7 server.
	# For this module to function properly, you should include the ssh module, since it has the sshfs installation included. 
	# The module was made for Linux Mint, but should work in any debian distribution.
	# rename "user1" for your need. The password hash can be created in debian by command = openssl passwd -1
	# rename the mount folder for your need. 
	# You must reboot the system after installation for the fstab file to load.
	# in nautilus, the mount folder will appear in the "devices" section. In command line type "mount <mount folder>" for mounting.    
	
	user {'user1':
                name => 'user1',
                password => '<password hash>',
                ensure => present,
                managehome => true,
                shell => '/bin/bash',		               
        }

	# Folder for sshfs mount point.
	
	file {'/home/user1/data/':
		ensure => directory,
		owner => 'user1',
		group => 'user1',
		require => User ['user1'],
	}

	# entry for the /etc/fstab file.
	
	file_line {'/etc/fstab':
		ensure => present,
		path => '/etc/fstab',
		line => 'sshfs#<username>@< IP or host address>:/user/folder/	/home/user1/data	fuse	comment=sshfs,noauto,users,exec,uid=1000,gid=1000,reconnect,follow_symlinks,allow_other,BatchMode=yes 0 0',
		require => User ['hanna'],
	}

	# fuse.conf file for the sshfs mount

	file {'/etc/fuse.conf':
		ensure => present,
		content => template('linuxmint/fuse.conf'),
		require => User ['user1'],
	}
}
