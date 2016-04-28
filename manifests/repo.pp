# cockpit::repo - Used for managing package repositories for cockpit
#
class cockpit::repo {

  if $::cockpit::manage_repo {

    case $::osfamily {
      'RedHat': {

        case $::operatingsystem {
          'CentOS': {
            include ::cockpit::repo::centos
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
