class cockpit::repo::centos {

  case $::operatingsystemmajrelease {
    '7': {
      yumrepo { 'group_cockpit-cockpit-preview':
        ensure              => 'present',
        baseurl             => 'https://copr-be.cloud.fedoraproject.org/results/@cockpit/cockpit-preview/epel-7-$basearch/',
        descr               => 'Copr repo for cockpit-preview owned by msuchy',
        enabled             => '1',
        gpgcheck            => '1',
        gpgkey              => 'https://copr-be.cloud.fedoraproject.org/results/@cockpit/cockpit-preview/pubkey.gpg',
        skip_if_unavailable => 'True',
      }
    }
    default: {

    }
  }

}
