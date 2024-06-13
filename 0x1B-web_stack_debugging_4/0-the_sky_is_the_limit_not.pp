reducing the number of failed requests on nginx

exec { 'fix--for-nginx':
  command => 'sed -i "s/15/4000/" /etc/default/nginx',
  path    => '/usr/local/bin/:/bin'
}

#restarting Nginx

exec { 'nginx-restart':
  command => 'nginx restart',
  path    => '/etc/init.d/'
}
