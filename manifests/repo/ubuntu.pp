class cockpit::repo::ubuntu {

  contain ::apt

  ::apt::source { 'cockpit':
    location => 'http://ppa.launchpad.net/cockpit-project/cockpit/ubuntu',
    release  => $::lsbdistcodename,
    repos    => 'main',
    key      => {
      id     => '637A2C82EDB1EF02DA658EE1046452EBC99782CC',
      server => 'keyserver.ubuntu.com',
    },
    notify   => Class['apt::update'],
  }

}
