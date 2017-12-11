class ufw {
	
	# This module is for configuring firewall rules in Linux mint / Ubuntu operating systems.
	# The specific firewall rules are located in the user.rules (ipv4) and user6.rules (ipv6) that reside in the
	# templates folder of this module.
	
	package { 'ufw':
		ensure => installed,		
	}
	
	file {'/etc/ufw/user.rules':
		content => template('ufw/user.rules'),
		require => Package ['ufw'],
		notify => Service ['ufw'],
	}
	
	file {'/etc/ufw/user6.rules':
		content => template('ufw/user6.rules'),
		require => Package ['ufw'],
		notify => Service ['ufw'],
	}
	
	service { 'ufw':
		ensure => running,
		enable => true,
		require => Package ['ufw'],
	}
}
