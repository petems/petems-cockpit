class cockpit::repo::ubuntu {
  contain apt

  ::apt::source { 'cockpit':
    location => 'http://ppa.launchpad.net/cockpit-project/cockpit/ubuntu',
    release  => $facts['os']['distro']['codename'],
    repos    => 'main',
    key      => {
      id     => '637A2C82EDB1EF02DA658EE1046452EBC99782CC',
      server => 'keyserver.ubuntu.com',
    },
    before   => Class['apt::update'],
  }
}
