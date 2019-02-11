# @api private
class anthill::def inherits anthill {

  # default virtualenv, used by pypigit
  anthill::python::virtualenv { "default":
    python_version => $anthill::python_version
  }

  # virtualenv for old 2 python (used by supervisor)
  anthill::python::virtualenv { "python2":
    python_version => $anthill::python2_version,
    custom_pip_conf => false
  }

}
