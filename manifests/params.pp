# cockpit::params - Default parameters
class cockpit::params {
  case $::osfamily {
    'RedHat': {
      $manage_repo     = true
      $yum_preview_repo = false
      $manage_package  = true
      $package_name    = 'cockpit'
      $package_version = 'installed'
      $service_name    = 'cockpit'
      $manage_service  = true
      $service_ensure  = 'running'
      $logintitle      = $::fqdn
      $allowunencrypted = false
      $maxstartups      = '10'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
