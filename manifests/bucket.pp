# @summary Configure a Scoop bucket
#
# @example Add a bucket
#   scoop::bucket { 'extras':
#     ensure => 'present',
#   }
#
# @example Remove a bucket
#   scoop::bucket { 'extras':
#     ensure => 'absent',
#   }
#
# @example Add a bucket by url
#   scoop::bucket { 'wangzq':
#     ensure => 'present',
#     url    => 'https://github.com/wangzq/scoop-bucket',
#   }
#
# @param name
#   The name of the bucket to create.
#
# @param ensure
#   Specifies whether to create the bucket. Valid values are 'present', 'absent'. Defaults to 'present'.
#
# @param url
#   Specifies the URL where the bucket's content is found. Defaults to undef, which means it should be a known bucket.
#
define scoop::bucket (
  Enum['present', 'absent'] $ensure = 'present',
  Optional[String] $url = undef,
) {
  include ::scoop::install

  $is_configured = member($facts['scoop']['buckets'], $name)

  case $ensure {
    'absent': {
      if $is_configured {
        exec { "scoop bucket rm ${name}":
          command  => "scoop bucket rm '${name}'",
          provider => 'powershell',
        }
      }
    }
    default: {
      # Empty url is ok; it then adds it from the "known" list
      # https://github.com/lukesampson/scoop/blob/master/buckets.json

      unless $is_configured {
        exec { "scoop bucket add ${name}":
          command  => "scoop bucket add '${name}' '${url}'",
          provider => 'powershell',
        }
      }
    }
  }
}
