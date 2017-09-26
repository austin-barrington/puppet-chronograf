# == Class: chronograf::service
#
# Optionally manage the Chronograf service.
#
class chronograf::service {

  assert_private()

  if $::chronograf::manage_service {
    service { 'chronograf':
      ensure    => running,
      hasstatus => true,
      enable    => true,
      restart   => 'pkill -HUP chronograf',
    }
  }
}
