class scoop::buckets {
  scoop::bucket { $scoop::buckets:
    ensure => present,
  }

  $scoop::url_buckets.each |$bucket, $url| {
    scoop::bucket { $bucket:
      ensure => present,
      url    => $url,
    }
  }
}
