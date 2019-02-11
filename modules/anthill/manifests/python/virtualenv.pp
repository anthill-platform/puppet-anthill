
define anthill::python::virtualenv (
  $python_version = $anthill::python_version,
  $custom_pip_conf = true
) {
  require anthill::python

  $path = "${anthill::virtualenv_location}/${title}"

  $virtualenv_path = [ "${anthill::pyenv_location}/versions/${python_version}/bin", '/bin', '/usr/bin', '/usr/sbin', '/usr/local/bin' ]

  exec { "python_${environment}_virtualenv_${title}":
    command     => "virtualenv ${path}",
    user        => $anthill::applications_user,
    group       => $anthill::applications_group,
    creates     => "${path}/bin/activate",
    path        => $virtualenv_path,
    cwd         => '/tmp'
  } -> # create a reliable symlink to site-packages dir of that virtualenv
  exec { "python_${environment}_${title}_symlink":
    command => "ln -s `${path}/bin/python -c \"from distutils import sysconfig; print(sysconfig.get_python_lib())\"` packages",
    creates => "${path}/packages",
    cwd => $path,
    path => [ '/bin', '/usr/bin', '/usr/sbin', '/usr/local/bin' ]
  }

  $python_index_location = anthill::ensure_location("python simple index location", $anthill::python_index_location, true)
  $simple_index_host = $python_index_location["host"]
  $simple_index_port = $python_index_location["port"]

  file { "${path}/pip.conf":
    ensure => $custom_pip_conf ? {
      true => present,
      false => absent
    },
    mode => '0770',
    content => template("anthill/pipconf.erb")
  }

}