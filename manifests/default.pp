class apache::default (
  $docroot = undef,
  ) {
    if $docroot {
      $httpd_docroot = $docroot
       } else {
       $httpd_docroot = $::osfamily ? {
        'redhat' => '/var/www/redhat',
         'debian' => '/var/www',
          }
          }
          file { "$httpd_docroot":
            ensure => directory,
             }
             
             file { "${httpd_docroot}/index.html":
               ensure  => file,
                 content => template('apache/index.html.erb'),
                 }
                 }
