class scoop (
  Enum['present', 'absent'] $ensure = 'present',
  Array[String] $buckets = [],
  Hash[String, String] $url_buckets = {},
  Array[String] $packages = [],
) {
  include ::scoop::install
  include ::scoop::buckets
  include ::scoop::packages
}
