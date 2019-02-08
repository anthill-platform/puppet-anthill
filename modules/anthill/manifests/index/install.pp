
class anthill::index::install inherits anthill::index {

  require anthill::python

  if ! defined(Class['anthill::supervisor']) {
    fail("class { anthill::supervisor: } is required to setup index ")
  }

  $pypi_args = "--port=${listen_port} --cache-directory=${cache_directory} --public-url=http://${anthill::internal_fqdn}:${listen_port} --repos=${repos_location}"
  $venv = "${anthill::virtualenv_location}/pypigit"

  $applications_user = $anthill::applications_user
  $applications_group = $anthill::applications_group

  anthill::python::virtualenv { "pypigit":
  } -> python::pip { "pypigit":
    virtualenv => $venv,
    ensure => $ensure
  } -> file { $cache_directory:
    ensure => 'directory',
    owner  => $application_user,
    group  => $application_group,
    mode   => '0766'
  } -> file { "/etc/systemd/system/${service_name}":
    ensure => $ensure,
    mode => '0770',
    content => template("anthill/pypigit.erb")
  } ~> exec { "${service_name}-systemd-reload":
    command     => 'systemctl daemon-reload',
    path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
    refreshonly => true,
  }

  service { $service_name:
    ensure => $ensure ? {
      'present' => running,
      'absent' => stopped
    },
    provider => systemd,
    enable => true,
    require => File["/etc/systemd/system/${service_name}"]
  }

}