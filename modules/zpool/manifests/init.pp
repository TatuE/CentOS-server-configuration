class zpool {

	# This module installs zpool and creates a mount for it. This needs the zfs module to be installed before hand.
	# When creatin a new zpool, use disc UUID so the configuration doesn't crash in the event of system disc changes. Using /dev/sd* value is discouraged.
	# The mount point in this module is inteded for the sshfs folder share. Change it to meet your needs.
	
	zpool {'centz01':
		pool => 'centz01',
		ensure => present,
		mirror => 'UUID1 UUID2',
	}
	
	zfs {'centz01':
		name => 'centz01',
		ensure => present,
		mountpoint => '/mnt/data',
		compression => on,
		require => Zpool ['centz01'],
	}
}
