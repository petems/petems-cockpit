# cockpit::config - Used for managing config files for a cockpit
#
class cockpit::config {
  ini_setting { 'Cockpit LoginTitle':
    ensure    => present,
    path      => '/etc/cockpit/cockpit.conf',
    section   => 'WebService',
    setting   => 'LoginTitle',
    value     => $::cockpit::logintitle,
    show_diff => true,
  }
}
