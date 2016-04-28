# cockpit::install - Used for managing packages for cockpit
#
class cockpit::install {

  if $::cockpit::manage_package {
    package { $::cockpit::package_name:
      ensure => $::cockpit::package_version,
    }
  }
}
