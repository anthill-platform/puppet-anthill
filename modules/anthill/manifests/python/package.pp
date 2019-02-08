
define anthill::python::package (
  String $package_name,
  String $package_version,
  String $api_version,
  Enum[present, abscent] $ensure                = present,
) {

  $venv = "${anthill::virtualenv_location}/${api_version}"

  $greate_or_eq = $package_version =~ /^>=/
  $fixed_package_version = $greate_or_eq ? {
    true => regsubst($package_version, '>=', ''),
    false => $package_version
  }

  $pip_package_version = $ensure ? {
    present => $fixed_package_version,
    default  => $ensure,
  }

  if ! defined(Anthill::Api::Version[$api_version]) {
    fail("Anthill API version ${api_version} is not defined")
  }

  $python_index_location = anthill::ensure_location("python simple index location", $anthill::python_index_location, true)
  $simple_index_host = $python_index_location["host"]
  $simple_index_port = $python_index_location["port"]

  python::pip { $title:
    pkgname => $package_name,
    virtualenv => $venv,
    search_index =>  "http://${simple_index_host}:${simple_index_port}/simple",
    ensure => $pip_package_version,
    greater_or_eq => $greate_or_eq,
    install_args => "--no-cache-dir"
  }
}