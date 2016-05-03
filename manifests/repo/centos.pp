class cockpit::repo::centos {

  if $::cockpit::yum_preview_repo {

    yumrepo { 'group_cockpit-cockpit-preview':
      ensure              => 'present',
      baseurl             => 'https://copr-be.cloud.fedoraproject.org/results/@cockpit/cockpit-preview/epel-7-$basearch/',
      descr               => 'Copr repo for cockpit-preview owned by msuchy',
      enabled             => '1',
      gpgcheck            => '1',
      gpgkey              => 'https://copr-be.cloud.fedoraproject.org/results/@cockpit/cockpit-preview/pubkey.gpg',
      skip_if_unavailable => 'True',
    }

  } else {

    yumrepo { 'extras':
      ensure     => 'present',
      descr      => 'CentOS-$releasever - Extras',
      gpgcheck   => '1',
      enabled    => '1',
      gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7',
      mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras&infra=$infra',
    }

  }

}
