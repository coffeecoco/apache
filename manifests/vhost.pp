define apache::vhost (
  $port = '80',
  $docowner= $apache::httpd_user,
  $docgroup = $apache::httpd_group,
  $confdir = $apache::httpd_conf_dot_d,
  $priority = '10',
  $options = 'Indexes MultiViews',
  $vhost_name = $title,
  $servername = $title,
  $docroot = "/var/www/${title}",
) {

  File {
    owner => $docowner,
    group => $docgroup,
    mode  => "0644",
  }

  file { "/etc/httpd/conf.d/${title}.conf":
    ensure  => file,
    content => template('apache/vhost.conf.erb'),
    notify  => Service[$apache::httpd_svc],
  }

  host { $title:
    ip => $ipaddress,
  }

  file { $docroot:
    ensure => directory,
  }

  file { "${docroot}/index.html":
    ensure  => file,
    content => $title,
  }
}
