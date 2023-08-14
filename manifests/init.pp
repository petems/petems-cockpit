# @summary
#   Used for managing installation and configuration of Cockpit (http://cockpit-project.org/)
#
# @example
#   include cockpit
#
# @example
#   class { 'cockpit':
#     manage_repo    => false,
#     package_name   => 'cockpit-custombuild',
#   }
#
# @author Peter Souter
#
# @param allowunencrypted
#   If true, cockpit will accept unencrypted HTTP connections.

#   Otherwise, it redirects all HTTP connections to HTTPS.
#   Exceptions are connections from localhost and for certain URLs (like /ping).
# @param logintitle
#   Title to show on login screen for cockpit
# @param manage_package
#   Whether to manage the cockpit package
# @param manage_repo
#   Whether to manage the package repositroy
# @param manage_service
# @param maxstartups
#   Specifies the maximum number of concurrent login attempts allowed
#
#   Additional connections will be dropped until authentication succeeds or the connections are closed.
# @param package_name
#   Name of the cockpit package
# @param package_version
#   Version of the cockpit package to install
# @param port
# @param service_ensure
#   What status the service should be enforced to
# @param service_name
#   Name of the cockpit service to manage
# @param yum_preview_repo
#   Whether to use the preview Yum repos to install package. See https://copr.fedorainfracloud.org/coprs/g/cockpit/cockpit-preview/
#
class cockpit (
  Boolean $allowunencrypted           = $cockpit::params::allowunencrypted,
  String $logintitle                  = $cockpit::params::logintitle,
  Boolean $manage_package             = $cockpit::params::manage_package,
  Boolean $manage_repo                = $cockpit::params::manage_repo,
  Boolean $manage_service             = $cockpit::params::manage_service,
  String $maxstartups                 = $cockpit::params::maxstartups,
  String $package_name                = $cockpit::params::package_name,
  String $package_version             = $cockpit::params::package_version,
  Optional[Stdlib::Port] $port        = $cockpit::params::port,
  String $service_ensure              = $cockpit::params::service_ensure,
  String $service_name                = $cockpit::params::service_name,
  Optional[Boolean] $yum_preview_repo = $cockpit::params::yum_preview_repo,
) inherits cockpit::params {
  contain cockpit::install
  contain cockpit::config

  Class['cockpit::install']
  -> Class['cockpit::config']

  if $manage_repo {
    contain cockpit::repo
    Class['cockpit::repo']
    ~> Class['cockpit::install']
  }

  if $manage_service {
    contain cockpit::service
    Class['cockpit::config']
    ~> Class['cockpit::service']
  }
}
