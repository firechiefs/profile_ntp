# The ntp module installs, configures, and manages the NTP service.
#
# HIERA DATA:
# Determining which ntp servers to use
#
# HIERA EXAMPLE:
# profile::ntp::servers:
#   - "0.us.pool.ntp.org iburst"
#   - "1.us.pool.ntp.org iburst"
#   - "2.us.pool.ntp.org iburst"
#   - "3.us.pool.ntp.org iburst"
# profile::ntp::package_ensure:
#   RedHat6:  '4.2.6p5-5.el6.centos.4'
#   RedHat7:  '4.2.6p5-22.el7.centos.2'
#
#
# module dependencies
# puppet module install puppetlabs-ntp

class profile::ntp {
  # returns RedHat6 or RedHat7
  $osfamily_majrel = "${::osfamily}${::operatingsystemmajrelease}"
  # Hiera lookups
  $servers        = hiera('profile::ntp::servers')
  $package_ensure = hiera('profile::ntp::package_ensure')

  # array of ntp servers
  validate_array($servers)
  # ntp package version
  validate_hash($package_ensure)

  # configure ntp with puppet module
  class { '::ntp':
    package_ensure =>
      $package_ensure[$osfamily_majrel],
    servers        => [ $servers ],
  }

  # validation script
  validation_script { 'profile_ntp':
    profile_name    => 'profile_ntp',
    validation_data => $servers,
  }

}
