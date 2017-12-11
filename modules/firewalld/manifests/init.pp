class firewalld {

	#Firewalld works in zones that have rules build in.
	# to modify the ports used, make according changes in the public.xml file (default zone) 
	# in this case the ports for PlexMediaServer and ssh are open.
	# if you have problems with puppet connection after installation, modify the zone file to open 8140 TCP port.  

	package {'firewalld':
		ensure => installed,
	}

	file {'/etc/firewalld/firewalld.conf':
		content => template ('firewalld/firewalld.conf'),
		require => Package ['firewalld'],
		notify => Service ['firewalld'],
	}
	
	file {'/etc/firewalld/zones/public.xml':
		content => template ('firewalld/public.xml'),
		require => Package ['firewalld'],
                notify => Service ['firewalld'],
	}

	service {'firewalld':
		ensure => running,
		enable => true,
		require => Package ['firewalld'],		
	}
}
