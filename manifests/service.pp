# cockpit::repo - Used for managing the cockpit service
#
# @api private
class cockpit::service {
  assert_private()

  service { $cockpit::service_name:
    ensure => $cockpit::service_ensure,
    enable => true,
  }
}
