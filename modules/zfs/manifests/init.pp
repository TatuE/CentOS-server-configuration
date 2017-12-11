class zfs {
	# This module install ZFS file system, it has been designed to work with centos7 operating system.
	# This installation is designed to use the kAbi-tracking kmod. This is recommended so you dont have to rebuild the system after kernel upgrade. If you wish to change this, make modifications to the zfs.repo file located in the templates folder in this module. 
	#If the modules dont load after installation, use command "modprobe zfs" in terminal.
   	
	
	package {'zfs-release':
		ensure => installed,
		provider => rpm,
		source => 'http://download.zfsonlinux.org/epel/zfs-release.el7_4.noarch.rpm',	
	}
	
	file {'/etc/yum.repos.d/zfs.repo':
		content => template ('zfs/zfs.repo'),
		require => Package ['zfs-release'],		
	}
	
	package {'zfs':
		ensure => installed,
		require => File ['/etc/yum.repos.d/zfs.repo'],
		provider => yum,
	}
	
	service {'zfs-import-cache':
		ensure => running,
		enable => true,
		hasstatus => true,
		hasrestart => true,
		require => Package ['zfs'],
	}

	service {'zfs-import-scan':
                ensure => running,
                enable => true,
                hasstatus => true,
                hasrestart => true,
                require => Package ['zfs'],
        }

	service {'zfs-mount':
                ensure => running,
                enable => true,
                hasstatus => true,
                hasrestart => true,
                require => Package ['zfs'],
        }

	service {'zfs-share':
                ensure => running,
                enable => true,
                hasstatus => true,
                hasrestart => true,
                require => Package ['zfs'],
        }

	service {'zfs-zed':
                ensure => running,
                enable => true,
                hasstatus => true,
                hasrestart => true,
                require => Package ['zfs'],
        }

	service {'zfs.target':
                ensure => running,
                enable => true,
                hasstatus => true,
                hasrestart => true,
                require => Package ['zfs'],
        }
}	
	
