class apache::params {
 case $::osfamily {
  "RedHat": {
  $httpd_user    = "apache"
  $httpd_group   = "apache"
  $httpd_pkg     = "httpd"
  $httpd_svc     = "httpd"
  $httpd_conf    = "httpd.conf"
  $httpd_confdir = "/etc/httpd/conf"
  }

"Debian": {
 $httpd_user    = "www-data"
 $httpd_group   = "www-data"
 $httpd_pkg     = "apache2"
 $httpd_svc     = "apache2"
 $httpd_conf    = "apache2.conf"
 $httpd_confdir = "/etc/apache2"
}
default: {
      fail("Module ${module_name} is not supported on ${::osfamily}")
 }
}
}

