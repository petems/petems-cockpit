# cockpit::params - Default parameters
class cockpit::params {

  # OS Specific Defaults
  case $::osfamily {
    'RedHat': {
      $yum_preview_repo = false
    }
    'Debian': {
      $yum_preview_repo = undef
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

  # Defaults for all Operating Systems
  # (Cockpit has consistant naming accross OS's, hooray! :D)
  $allowunencrypted = false
  $logintitle       = $::fqdn
  $manage_package   = true
  $manage_repo      = true
  $manage_service   = true
  $maxstartups      = '10'
  $package_name     = 'cockpit'
  $package_version  = 'installed'
  $port             = undef
  $service_ensure   = 'running'
  $service_name     = 'cockpit'

}
