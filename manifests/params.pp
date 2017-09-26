# == Class: chronograf::params
#
# A set of default parameters for Telegraf's configuration.
#
class chronograf::params {

  $ensure                 = 'present'
  $hostname               = $::hostname
  $global_tags            = {}
  $manage_service         = true
  $manage_repo            = true
  $repo_type              = 'stable'

}
