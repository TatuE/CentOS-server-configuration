class epel {
	
	# EPEL = extra packages for enterprise linux. Add the repo for packages not in the mainstream RHEL repo, like sshfs etc.
	package {'epel-release':
		ensure => latest,
	}
}
