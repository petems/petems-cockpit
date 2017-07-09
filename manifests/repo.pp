# cockpit::repo - Used for managing package repositories for cockpit
#
class cockpit::repo {

  if $::cockpit::manage_repo {

    case $::osfamily {
      'RedHat': {
        case $::operatingsystem {
          'CentOS': {
            contain ::cockpit::repo::centos
          }
          'Fedora': {
            contain ::cockpit::repo::fedora
          }
          default: {
            # code
          }
        }
      }
      'Debian': {
        case $::operatingsystem {
          'Ubuntu': {
            contain ::cockpit::repo::ubuntu
          }
          'Debian': {
            contain ::cockpit::repo::debian
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
