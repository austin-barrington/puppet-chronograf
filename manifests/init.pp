# == Class: chronograf
#
# A Puppet module for installing InfluxData's chronograf
#
# === Parameters
#
# [*ensure*]
#   String. State of the chronograf package. You can also specify a
#   particular version to install.
#
# [*config_file*]
#   String. Path to the configuration file.
#
# [*hostname*]
#   String. Override default hostname used to identify this agent.
#
# [*interval*]
#   String. Default data collection interval for all inputs.
#
# [*round_interval*]
#   Boolean. Rounds collection interval to 'interval'
#
# [*metric_buffer_limit*]
#   Integer. Cache metric_buffer_limit metrics for each output, and flush this
#   buffer on a successful write.
#
# [*flush_buffer_when_full*]
#   Boolean. Flush buffer whenever full, regardless of flush_interval
#
# [*collection_jitter*]
#   String.  Sleep for a random time within jitter before collecting.
#
# [*flush_interval*]
#   String. Default flushing interval for all outputs.
#
# [*flush_jitter*]
#   String.  Jitter the flush interval by an amount.
#
# [*debug*]
#   Boolean. Run chronograf in debug mode.
#
# [*quiet*]
#   Boolean.  Run chronograf in quiet mode.
#
# [*outputs*]
#   Hash. Specify output plugins and their options.
#
# [*inputs*]
#   Hash.  Specify input plugins and their options.
#
# [*global_tags*]
#   Hash.  Global tags as a key-value pair.
#
# [*manage_service*]
#   Boolean.  Whether to manage the chronograf service or not.
#
# [*manage_repo*]
#   Boolean.  Whether or not to manage InfluxData's repo.
#
# [*repo_type*]
#   String.  Which repo (stable, unstable, nightly) to use
#
class chronograf (
  $ensure                 = $chronograf::params::ensure,
  $hostname               = $chronograf::params::hostname,
  $manage_service         = $chronograf::params::manage_service,
  $manage_repo            = $chronograf::params::manage_repo,
  $repo_type              = $chronograf::params::repo_type,
) inherits ::chronograf::params
{

  validate_string($ensure)
  validate_string($hostname)
  validate_bool($manage_service)
  validate_bool($manage_repo)
  validate_string($repo_type)

  contain ::chronograf::install
  contain ::chronograf::service

  Class['::chronograf::install'] ->
  Class['::chronograf::service']
}
