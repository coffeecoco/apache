class apache ($docroot = undef,
 $httpd_user    = $apache::params::httpd_user,
 $httpd_group   = $apache::params::httpd_group,
 $httpd_pkg     = $apache::params::httpd_pkg,
 $httpd_svc     = $apache::params::httpd_svc,
 $httpd_conf    = $apache::params::httpd_conf,
 $httpd_confdir = $apache::params::httpd_confdir,
# $httpd_docroot = $apache::params::httpd_docroot,
 ) inherits apache::params {

if $docroot {
  $httpd_docroot = $docroot
} else {
$httpd_docroot = $::osfamily ? {
  'redhat' => '/var/www/html',
  'debian' => '/var/www',
 }
}
File {
 ensure => file,
 owner  => "$httpd_user",
 group  => "$httpd_user",
 mode   => "0644",
}
        
package { "$httpd_pkg":
 ensure  => present,
}

file {"${httpd_confdir}/${httpd_conf}":
 ensure => file,
    source => "puppet:///modules/apache/${httpd_conf}",
    owner   => "root",
    group   => "root",
    mode    => "0755",
before => Service["$httpd_svc"],
}

 
file { "/var/www/html":
 ensure => directory,
   before => Service[$httpd_svc],
}

#file { '/etc/httpd/conf.d/vhost.conf':
#  ensure  => present,
#  content => template('apache/vhost.conf.erb'),
#  before => Service[$httpd_svc],
#  notify => Service[$httpd_svc],   
# }
 
file {"/var/www/html/index.html":
  ensure  => file,
   #source => "puppet:///modules/apache/index.html",
   content =>  template("apache/index.html.erb"),
   before => Service[$httpd_svc],
   notify => Service[$httpd_svc],
}

service {$httpd_svc:
  ensure => true,
  enable => true,
  require => Package[$httpd_svc],
  subscribe => File["${httpd_confdir}/${httpd_conf}"],
}
# apache::vhost { $::fqdn:
#  docroot => $httpd_docroot,
# }    

}
