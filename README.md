## PURPOSE:

The ntp module installs, configures, and manages the NTP service.

## HIERA DATA:
```
profile::ntp:
```
Determining which ntp servers to use

## HIERA EXAMPLE:
```
  profile::ntp::servers:
    - "0.us.pool.ntp.org iburst"
    - "1.us.pool.ntp.org iburst"
    - "2.us.pool.ntp.org iburst"
    - "3.us.pool.ntp.org iburst"

  profile::ntp::package_ensure: '4.2.6p5-5.el6.centos.4'

```

## MODULE DEPENDENCIES:
```
puppet module install puppetlabs-ntp
```
## USAGE:

#### Puppetfile:
```
mod "puppetlabs-ntp",        '4.1.2'

mod 'validation_script',
  :git => 'https://github.com/firechiefs/validation_script',
  :ref => '1.0.0'

mod 'profile_ntp',
  :git => 'https://github.com/firechiefs/profile_ntp',
  :ref => '1.0.0'
```
#### Manifests:
```
#RedHat family specific profiles
if ($::osfamily == 'RedHat') {
  class role::*rolename* {
    include profile_ntp
  }
}
```
