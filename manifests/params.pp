# cockpit::params - Default parameters
class cockpit::params {
  case $::osfamily {
    'RedHat': {
      $manage_repo     = true
      $manage_package  = true
      $package_name    = 'cockpit'
      $package_version = 'installed'
      $service_name    = 'cockpit'
      $manage_service  = true
      $service_ensure  = 'running'
      $logintitle      = $::fqdn
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
