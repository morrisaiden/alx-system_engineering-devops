# Reducing the no of failed requests

exec { 'fix--for-nginx':
  command => 'sed -i "s/15/65535/" /etc/default/nginx',
  path    => '/usr/local/bin/:/bin'
}

#restart Nginx

exec { 'nginx-restart':
  command => 'nginx restart',
  path    => '/etc/init.d/'
}
