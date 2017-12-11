class plex {

	# this module will install Plex media server. It is build to work with centos7 operating system.
	# If you have a pre existing configuration for userid etc. you can migrate them by coping the Preferences.xml file to the templates folder (in this module it's not included). 
	# if you dont, you can comment the file resource out.
	# If you wish to change the defaul ples user, you can change it in the PlexMediaServer file. Notice that you have to chmod the plex folder for that specific user, so the program can read them.

	package {'plexmediaserver':
		ensure => installed,
		provider => rpm,
		source => 'https://downloads.plex.tv/plex-media-server/1.10.0.4523-648bc61d4/plexmediaserver-1.10.0.4523-648bc61d4.x86_64.rpm',
	}

	file {'/etc/sysconfig/PlexMediaServer':
		ensure => present,
		content => template('plex/PlexMediaServer'),
		require => Package ['plexmediaserver'],		
	}

	file {'/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Preferences.xml':
                ensure => present,
                content => template('plex/Preferences.xml'),
                require => Package ['plexmediaserver'],
                notify => Service ['plexmediaserver'],
        }
	
	service {'plexmediaserver':
		ensure => running,
		enable => true,
		require => Package ['plexmediaserver'],
	}
}
	
