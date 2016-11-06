class cockpit::repo::ubuntu {

  contain ::apt

  ::apt::ppa { 'ppa:cockpit-project/cockpit':
    before     => Class['apt::update'],
  }

}
