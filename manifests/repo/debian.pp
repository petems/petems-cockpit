class cockpit::repo::debian {

  contain ::apt

  apt::source { 'cockpit_unstable':
    location => 'https://fedorapeople.org/groups/cockpit/debian',
    release  => 'unstable',
    repos    => 'main',
    key      => {
      'id'     => 'FD9A576417F7B1D863C47A5A0D2A45C3F1BAA57C',
      'server' => 'sks-keyservers.net',
    },
    before   => Class['apt::update'],
  }

}
