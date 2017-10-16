# == Class: chronograf::install
#
# Conditionally handle InfluxData's official repos and install the necessary
# Telegraf package.
#
class chronograf::install {

  assert_private()

  $_operatingsystem = downcase($::operatingsystem)

  if $::chronograf::manage_repo {
    case $::osfamily {
      'Debian': {
        apt::source { 'influxdata':
          comment  => 'Mirror for InfluxData packages',
          location => "https://repos.influxdata.com/${_operatingsystem}",
          release  => $::lsbdistcodename,
          repos    => $::chronograf::repo_type,
          key      => {
            'id'     => '05CE15085FC09D18E99EFB22684A14CF2582E0C5',
            'source' => 'https://repos.influxdata.com/influxdb.key',
          },
        }
        Class['apt::update'] -> Package['chronograf']
      }
      'RedHat': {
        yumrepo { 'influxdata':
          descr    => 'influxdata',
          enabled  => 1,
          baseurl  => "https://repos.influxdata.com/rhel/${::operatingsystemmajrelease}/${::architecture}/${::chronograf::repo_type}",
          gpgkey   => 'https://repos.influxdata.com/influxdb.key',
          gpgcheck => true,
        }
        Yumrepo['influxdata'] -> Package['chronograf']
      }
      default: {
        fail('Only RedHat, CentOS, Debian and Ubuntu are supported at this time')
      }
    }
  }

  ensure_packages(['chronograf'], { ensure => $::chronograf::ensure })

}
