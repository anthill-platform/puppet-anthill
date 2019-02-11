#
# Installs Python interpreter
#
# @api private
#
class anthill::python inherits anthill {

  $virtualenv_path = [ "${pyenv_location}/versions/${python_version}/bin", '/bin', '/usr/bin', '/usr/sbin', '/usr/local/bin' ]
  $virtualenv2_path = [ "${pyenv_location}/versions/${python2_version}/bin", '/bin', '/usr/bin', '/usr/sbin', '/usr/local/bin' ]
  $pyenv_path = [ "${pyenv_location}/bin", '/bin', '/usr/bin', '/usr/sbin', '/usr/local/bin' ]
  $pypi_index = ""

  file { $virtualenv_location:
    ensure => 'directory',
    owner  => $anthill::applications_user,
    group  => $anthill::applications_group,
    mode   => '0760'
  } -> # install the pyenv
  vcsrepo { $pyenv_location:
    ensure   => present,
    owner    => $applications_user,
    group    => $applications_group,
    provider => 'git',
    source   => 'https://github.com/pyenv/pyenv.git',
    revision => 'v1.2.7'
  } -> # install the python of ${python_version}
  exec { "python_${python_version}_install":
    command     => "pyenv install ${python_version}",
    user        => $applications_user,
    group       => $applications_group,
    creates     => "${pyenv_location}/versions/${python_version}",
    path        => $pyenv_path,
    cwd         => '/tmp',
    timeout     =>  0,
    environment => [
      "PYENV_ROOT=${pyenv_location}"
    ]
  } -> # install virtualenv for ${python_version}
  exec { "python_${python_version}_virtualenv":
    command     => "pip install --upgrade pip setuptools virtualenv",
    user        => $applications_user,
    group       => $applications_group,
    creates     => "${pyenv_location}/versions/${python_version}/bin/virtualenv",
    path        => $virtualenv_path,
    cwd         => '/tmp',
    timeout     =>  0,
  } -> # install the python of ${python2_version}
  exec { "python_${python2_version}_install":
    command     => "pyenv install ${python2_version}",
    user        => $applications_user,
    group       => $applications_group,
    creates     => "${pyenv_location}/versions/${python2_version}",
    path        => $pyenv_path,
    cwd         => '/tmp',
    timeout     =>  0,
    environment => [
      "PYENV_ROOT=${pyenv_location}"
    ]
  } -> # install virtualenv for ${python2_version}
  exec { "python_${python2_version}_virtualenv":
    command     => "pip install --upgrade pip setuptools virtualenv",
    user        => $applications_user,
    group       => $applications_group,
    creates     => "${pyenv_location}/versions/${python2_version}/bin/virtualenv",
    path        => $virtualenv_path,
    cwd         => '/tmp',
    timeout     =>  0,
  }

  if ($::operatingsystem == 'Debian' and $::operatingsystemmajrelease == '9') {
    $libmysqlclientdev_name = 'default-libmysqlclient-dev'
  } else {
    $libmysqlclientdev_name = 'libmysqlclient-dev'
  }
}