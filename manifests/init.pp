# cockpit - Used for managing installation and configuration
# of Cockpit (http://cockpit-project.org/)
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
# @param logintitle [String] Title to show on login screen for cockpit
#
# @param manage_package [Boolean] Whether to manage the cockpit package
#
# @param manage_repo [Boolean] Whether to manage the package repositroy
#
# @param package_name [String] Name of the cockpit package
#
# @param package_version [String] Version of the cockpit package to install
#
# @param service_name [String] Name of the cockpit service to manage
#
# @param service_ensure [String] What status the service should be enforced to
#
class cockpit (
  $logintitle     = $::cockpit::params::logintitle,
  $manage_package  = $::cockpit::params::manage_package,
  $manage_repo     = $::cockpit::params::manage_repo,
  $package_name    = $::cockpit::params::package_name,
  $package_version = $::cockpit::params::package_version,
  $service_name    = $::cockpit::params::service_name,
  $service_ensure  = $::cockpit::params::service_ensure,
) inherits ::cockpit::params {

  validate_string($logintitle)
  validate_bool($manage_package)
  validate_bool($manage_repo)
  validate_string($package_name)
  validate_string($package_version)
  validate_string($service_name)
  validate_string($service_ensure)

  class { '::cockpit::repo': } ->
  class { '::cockpit::install': } ->
  class { '::cockpit::config': } ~>
  class { '::cockpit::service': } ->
  Class['::cockpit']
}
