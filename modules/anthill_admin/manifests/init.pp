
class anthill_admin (

  String $default_version                       = $anthill::default_version,

  Enum['present', 'absent'] $ensure             = 'present',
  String $service_name                          = $anthill_admin::params::service_name,
  String $server_name                           = $anthill_admin::params::server_name,
  String $package_name                          = $anthill_admin::params::package_name,
  String $package_directory                     = $anthill_admin::params::package_directory,

  String $db_location                           = $anthill_admin::params::db_location,
  Optional[Boolean] $manage_db                  = true,
  String $db_name                               = $anthill_admin::params::db_name,

  String $token_cache_location                  = $anthill_admin::params::token_cache_location,
  Integer $token_cache_db                       = $anthill_admin::params::token_cache_db,
  Integer $token_cache_max_connections          = $anthill_admin::params::token_cache_max_connections,

  String $cache_location                        = $anthill_admin::params::cache_location,
  Integer $cache_db                             = $anthill_admin::params::cache_db,
  Integer $cache_max_connections                = $anthill_admin::params::cache_max_connections,

  Boolean $enable_monitoring                    = $anthill_admin::params::enable_monitoring,
  String $monitoring_location                   = $anthill_admin::params::monitoring_location,

  Boolean $debug                                = $anthill::debug,

  String $internal_broker_location              = $anthill_admin::params::internal_broker_location,
  String $pubsub_location                       = $anthill_admin::params::pubsub_location,

  String $nginx_max_body_size                   = $anthill_admin::params::nginx_max_body_size,

  Optional[String] $discovery_service           = undef,
  Optional[String] $host                        = undef,
  Optional[String] $domain                      = undef,
  Optional[String] $external_domain_name        = undef,
  Optional[String] $internal_domain_name        = undef,

  Optional[Array[String]] $internal_restrict    = undef,
  Optional[Integer] $internal_max_connections   = undef,
  Optional[String] $auth_key_public             = undef,
  Optional[Array[String]] $whitelist            = undef

) inherits anthill_admin::params {

  require anthill::common

  anthill::service { $service_name:
    package_directory => $package_directory,
    default_version => $default_version,
    python_package_name => $package_name,
    service_name => $service_name,
    ensure => $ensure,
    domain => $domain,
    external_domain_name => $external_domain_name,
    internal_domain_name => $internal_domain_name,
    internal_broker_location => $internal_broker_location,
    whitelist => $whitelist,

    nginx_max_body_size => $nginx_max_body_size
  }

  if ($manage_db)
  {
    @@mysql_database { $db_name:
      ensure => 'present',
      charset => 'utf8',
      tag => [ $db_location, "env-${environment}" ]
    }
  }

}
