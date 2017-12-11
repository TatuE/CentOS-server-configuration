class ssh {

	#This module installs openssh-server, openssh-client and sshfs. It has been designed to work with redhat (centos, fedora etc.) and debian (Ubuntu, linux mint etc.) operatingsystem families.
	# By default, root connection via ssh has been disabled. To make additional changes, make them to the sshd_config file, that recides in the templates folder of this module.
	
	package {'openssh-server':
		ensure => installed,			
	}

	$openssh_clients = $::osfamily ? {
                debian => 'openssh-client',
                redhat => 'openssh-clients',
        }

	package {$openssh_clients:
                ensure => installed,
		alias => 'openssh-clients'
        }

	$sshfs = $::osfamily ? {
		debian => 'sshfs',
		redhat => 'fuse-sshfs',	
	}

	package {$sshfs:
                ensure => installed,
		alias => 'sshfs',
        }
	
	file {'/etc/ssh/sshd_config':
		content => template ('ssh/sshd_config'),
		require => Package ['openssh-server', 'openssh-clients', 'sshfs'],
		notify => Service ['sshd'],
	}
	
	service {'sshd':
		ensure => running,
		enable => true,
		require => Package ['openssh-server', 'openssh-clients', 'sshfs'],
	}
}
