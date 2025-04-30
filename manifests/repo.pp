# cockpit::repo - Used for managing package repositories for cockpit
#
class cockpit::repo {
  if $cockpit::manage_repo {
    case $facts['os']['family'] {
      'RedHat': {
        case $facts['os']['operatingsystem'] {
          'CentOS': {
            require cockpit::repo::centos
          }
          'Fedora': {
            require cockpit::repo::fedora
          }
          default: {
            # code
          }
        }
      }
      'Debian': {
        case $facts['os']['operatingsystem'] {
          'Ubuntu': {
            require cockpit::repo::ubuntu
          }
          'Debian': {
            require cockpit::repo::debian
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
}
