class cockpit::repo::fedora {

  if $::cockpit::yum_preview_repo {

    yumrepo { 'group_cockpit-cockpit-preview':
      ensure              => 'present',
      baseurl             => 'https://copr-be.cloud.fedoraproject.org/results/@cockpit/cockpit-preview/fedora-$releasever-$basearch/',
      descr               => 'Copr repo for cockpit-preview owned by msuchy',
      enabled             => '1',
      gpgcheck            => '1',
      gpgkey              => 'https://copr-be.cloud.fedoraproject.org/results/@cockpit/cockpit-preview/pubkey.gpg',
      skip_if_unavailable => true,
    }

  } else {

    yumrepo { 'updates':
      ensure              => 'present',
      descr               => 'Fedora $releasever - $basearch - Updates',
      enabled             => '1',
      failovermethod      => 'priority',
      gpgcheck            => '1',
      gpgkey              => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch',
      metadata_expire     => '6h',
      metalink            => 'https://mirrors.fedoraproject.org/metalink?repo=updates-released-f$releasever&arch=$basearch',
      skip_if_unavailable => false,
    }

  }

}
