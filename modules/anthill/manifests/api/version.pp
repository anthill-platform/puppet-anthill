
define anthill::api::version (
  String $common_package_version,
  String $api_version                           = $title,
  Enum[present, abscent] $ensure                = present,
) {
  $venv = "${anthill::virtualenv_location}/${api_version}"

  $greate_or_eq = $common_package_version =~ /^>=/
  $fixed_common_package_version = $greate_or_eq ? {
    true => regsubst($common_package_version, '>=', ''),
    false => $common_package_version
  }

  $pip_package_version = $ensure ? {
    present => $fixed_common_package_version,
    default  => $ensure,
  }

  $python_index_location = anthill::ensure_location("python simple index location", $anthill::python_index_location, true)
  $simple_index_host = $python_index_location["host"]
  $simple_index_port = $python_index_location["port"]

  anthill::python::virtualenv { $api_version: } -> python::pip { "api_version_${api_version}":
    pkgname => $anthill::common::packge_name,
    virtualenv => $venv,
    ensure => $pip_package_version,
    greater_or_eq => $greate_or_eq,
    search_index =>  "http://${simple_index_host}:${simple_index_port}/simple",
    install_args => "--no-cache-dir"
  }
}