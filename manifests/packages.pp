class scoop::packages {
  scoop::package { $scoop::packages:
    ensure  => present,
    require => Class['scoop::buckets'],
  }
}
