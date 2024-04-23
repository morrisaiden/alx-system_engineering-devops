#!/usr/bin/env bash
#add nginx
exec { 'add nginx stable repo':
  command => 'sudo add-apt-repository ppa:nginx/stable',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

#update softwares
exec { 'update packages':
  command => 'apt-get update',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

#install nginx
package { 'nginx':
  ensure     => 'installed',
}

#permit http
exec { 'allow HTTP':
  command => "ufw allow 'Nginx HTTP'",
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  onlyif  => '! dpkg -l nginx | egrep \'îi.*nginx\' > /dev/null 2>&1',
}

exec { 'chmod www folder':
  command => 'chmod -R 755 /var/www',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

file { '/var/www/html/index.html':
  content => "Hello World!\n",
}

file { '/var/www/html/404.html':
  content => "Ceci n'est pas une page\n",
}

file { 'Nginx default config file':
  ensure  => file,
  path    => '/etc/nginx/sites-enabled/default',
  content =>
"server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html index.htm;

    server_name _;

    location /redirect_me/ {
        return 301 http://www.morrisaidenx.tech;
    }

    error_page 404 /404.html;
    location = /404.html{
        root /etc/nginx/html;
        internal;
    }
}"

exec { 'restart service':
  command => 'service nginx restart',
  path    => '/usr/bin:/usr/sbin:/bin',
}

service { 'nginx':
  ensure  => running,
  require => Package['nginx'],
}
