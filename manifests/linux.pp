# Class: puppet_masterless::linux
# ===========================
#
# Manageds puppet_masterless config on linux nodes
#
class puppet_masterless::linux {

  $site_path = "/etc/puppetlabs/code/environments/{$environment}/manifests/site.pp"

  # use r10k to update environment/modules/hieradata
  cron { 'r10k_updater':
    command => '/usr/bin/r10k deploy environment -pv',
    user    => 'root',
    minute  => [15,45],
  }

  # run puppet apply against site.pp (i.e. masterless)
  cron { 'puppet_masterless':
    command => "/opt/puppetlabs/bin/puppet apply ${site_path}",
    user    => 'root',
    minute  => [0,30],
  }

}
