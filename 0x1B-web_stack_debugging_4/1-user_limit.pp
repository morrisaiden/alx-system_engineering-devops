# changing OS config for holberton user

exec { 'increase-hard-file-limit':
  command => 'sed -i "/holberton hard/s/5/65535/" /etc/security/limits.conf',
  path    => '/usr/local/bin/:/bin/'
}

exec { 'increase-soft-file-limit':
  command => 'sed -i "/holberton soft/s/4/4096/" /etc/security/limits.conf',
  path    => '/usr/local/bin/:/bin/'
}
