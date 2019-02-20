#
# PyPiGIT git-based python package index
#
class anthill::index (
  Boolean $export_location                                = true,
  String $export_location_name                            = "pyindex-${hostname}",

  Enum[present, absent] $ensure                           = present,
  String $index_location                                  = "/opt/pyindex",
  String $cache_directory                                 = "${index_location}/cache",
  String $repos_location                                  = "${index_location}/repos.yaml",
  Integer $listen_port                                    = $anthill::index::params::listen_port,
  String $service_name                                    = $anthill::index::params::service_name,
) inherits anthill::index::params {

  file { $index_location:
    ensure => 'directory',
    owner  => $anthill::applications_user,
    group  => $anthill::applications_group,
    mode   => '0766'
  }

  anchor { 'anthill::index::begin': } ->
  class { '::anthill::index::repos': } ->
  class { '::anthill::index::install': } ->
  class { '::anthill::index::location': } ->
  anchor { 'anthill::index::end': }

}