class centosusr {

	#name for the group to be assigned for folder sharing = GID.
	# if you wish to share a folder with all the users, they must belong to this group 
	group {'<folder sharing group>':
		name => '<folder sharing group>',
		ensure => present,

	}
	
	#user1, also in the admin 'wheel' group, 
	# password must be a hash not plain text, otherwise it will not work (at least in puppet 3.8.5)
	# in ubuntu/debian (confirmed), you can create the has by using openssl => "openssl passwd -1".	 
	 
	user {'usesr1':
		name => 'user1',
		password => '<password hash>', 
		ensure => present,
		groups => ['wheel','<folder sharing group>'],
		managehome => true,
		shell => '/bin/bash',
		require => Group ['<folder sharing group>'],
	}

	# the folder to be shared
	# mode must be 2770 for the folder rights to be consistent with the purpose

	file {'/mnt/data':
		ensure=> directory,
		owner => 'user1',
		group => '<folder sharing group>',
		mode => 2770,
		require => User['user2'], 
	}
	
	#The folder share works by linkin user directories to it

	file {'/home/user1/data':
                ensure=> link,
                target => '/mnt/data',
                owner => 'user1',
                group => '<folder sharing group>',
                mode => 2770,
                require => File ['/mnt/data'],
        }

	#user2 a regular, non admin user in the system.

	user {'user2':
                name => 'user2',
                password => '<password hash>',
                ensure => present,
                groups => '<folder sharing group>',
                managehome => true,
                shell => '/bin/bash',
		require => Group ['<folder sharing group>'],
        }

	# users linked folder

        file {'/home/user2/data':
                ensure=> link,
                target => '/mnt/data',
		owner => 'user2',
                group => '<folder sharing group>',
		mode => 2770,
                require => File ['/mnt/data'],			
        }

	#to prevent root login in shell.
	user {'root':
                shell => '/sbin/nologin',
                require => User ['user1'],
        }

}
