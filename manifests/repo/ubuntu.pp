class cockpit::repo::ubuntu {

  contain ::apt

  #
  # apt::ppa is broken on Ubuntu 16.04
  # Fixed upstream, awaiting release: https://github.com/puppetlabs/puppetlabs-apt/pull/604
  #
  # When it works, we can do this instead:
  #
  # ::apt::ppa { 'ppa:cockpit-project/cockpit':
  #   before     => Class['apt::update'],
  # }

  $release          = $::apt::xfacts['lsbdistcodename']
  $ubuntu_repo_name = 'ppa:cockpit-project/cockpit'

  if versioncmp($::apt::xfacts['lsbdistrelease'], '15.10') >= 0 {
    $distid = downcase($::apt::xfacts['lsbdistid'])
    $filename = regsubst($ubuntu_repo_name, '^ppa:([^/]+)/(.+)$', "\\1-${distid}-\\2-${release}")
  } else {
    $filename = regsubst($ubuntu_repo_name, '^ppa:([^/]+)/(.+)$', "\\1-\\2-${release}")
  }

  $filename_no_slashes      = regsubst($filename, '/', '-', 'G')
  $filename_no_specialchars = regsubst($filename_no_slashes, '[\.\+]', '_', 'G')
  $sources_list_d_filename  = "${filename_no_specialchars}.list"

  exec { 'cockpit-add-apt-repository-ppa:cockpit-project/cockpit':
    command   => '/usr/bin/add-apt-repository ppa:cockpit-project/cockpit',
    unless    => "/usr/bin/test -s ${::apt::sources_list_d}/${sources_list_d_filename}",
    user      => 'root',
    logoutput => 'on_failure',
    notify    => Class['apt::update'],
  }

}
