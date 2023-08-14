# @summary Default parameters
#
# @api private
class cockpit::params {
  assert_private()

  # OS Specific Defaults
  case $facts['os']['family'] {
    'RedHat': {
      $yum_preview_repo = false
    }
    'Debian': {
      $yum_preview_repo = undef
    }
    default: {
      fail("${facts['os']['family']} not supported")
    }
  }

  # Defaults for all Operating Systems
  # (Cockpit has consistant naming accross OS's, hooray! :D)
  $allowunencrypted = false
  $logintitle       = $facts['networking']['fqdn']
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
