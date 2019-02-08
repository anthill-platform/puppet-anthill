class anthill::index::location inherits anthill::index {

  if ($export_location)
  {
    anthill::location { $export_location_name:
      data => {
        "host" => $anthill::internal_fqdn,
        "port" => $listen_port
      }
    }
  }

}