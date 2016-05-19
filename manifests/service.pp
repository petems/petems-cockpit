# cockpit::repo - Used for managing the cockpit service
#
class cockpit::service {

  if $::cockpit::manage_service {
    # Puppet runs to enable the service are bugged
    # on Puppet 4.X onwards for systemd
    # See PUP-5296
    # This is fixed but awaiting a Puppet 4.5 release
    service { $::cockpit::service_name:
      ensure     => $::cockpit::service_ensure,
      # enable     => true,
    }
  }
}
