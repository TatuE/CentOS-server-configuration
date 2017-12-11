class ufw {

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
