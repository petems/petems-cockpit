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

  ini_setting { 'Cockpit MaxStartups':
    ensure    => present,
    path      => '/etc/cockpit/cockpit.conf',
    section   => 'WebService',
    setting   => 'MaxStartups',
    value     => $::cockpit::maxstartups,
    show_diff => true,
  }

  ini_setting { 'Cockpit AllowUnencrypted':
    ensure    => present,
    path      => '/etc/cockpit/cockpit.conf',
    section   => 'WebService',
    setting   => 'AllowUnencrypted',
    value     => $::cockpit::allowunencrypted,
    show_diff => true,
  }

  if $::cockpit::port {
    file { '/etc/systemd/system/cockpit.socket.d/':
      ensure => directory,
      owner  => 'root',
      group  => 'root',
    }
    ->
    file { '/etc/systemd/system/cockpit.socket.d/listen.conf':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      content => template('cockpit/etc/systemd/system/cockpit.socket.d/listen.conf.erb'),
    }
    ~>
    exec { 'Cockpit systemctl daemon-reload':
      command     => 'systemctl daemon-reload',
      refreshonly => true,
      path        => $::path,
    }
  }

}
