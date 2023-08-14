# @summary Used for managing package repositories for cockpit
#
# @api private
class cockpit::repo {
  assert_private()

  case $facts['os']['family'] {
    'RedHat': {
      case $facts['os']['name'] {
        'CentOS': {
          contain cockpit::repo::centos
        }
        'Fedora': {
          contain cockpit::repo::fedora
        }
        default: {
          # code
        }
      }
    }
    'Debian': {
      case $facts['os']['name'] {
        'Ubuntu': {
          contain cockpit::repo::ubuntu
        }
        'Debian': {
          contain cockpit::repo::debian
        }
        default: {
          # code
        }
      }
    }
    default: {
      # code
    }
  }
}
