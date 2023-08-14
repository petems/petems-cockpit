# @summary Used for managing packages for cockpit
#
# @api private
class cockpit::install {
  assert_private()

  if $cockpit::manage_package {
    package { $cockpit::package_name:
      ensure => $cockpit::package_version,
    }
  }
}
