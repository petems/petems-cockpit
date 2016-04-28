# cockpit::repo - Used for managing the cockpit service
#
class cockpit::service {

  if $::cockpit::manage_service {
    service { $::cockpit::service_name:
      ensure     => $::cockpit::service_ensure,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
    }
  }
}
