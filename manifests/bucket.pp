define scoop::bucket (
  Optional[String] $url = undef,
  Enum['present', 'absent'] $ensure = 'present',
) {
  $tester = "if(scoop bucket list | Select-String -Pattern '^${name}$' ) { exit 1 }"

  case $ensure {
    'absent': {
      exec { "scoop bucket rm ${name}":
        command   => "scoop bucket rm '${name}'",
        unless    => $tester,
        provider  => 'powershell',
        require   => Exec['install scoop'],
      }
    }
    default: {
      # Empty url is ok; it then adds it from the "known" list
      # https://github.com/lukesampson/scoop/blob/master/buckets.json
      
      exec { "scoop bucket add ${name}":
        command   => "scoop bucket add '${name}' '${url}'",
        onlyif    => $tester,
        provider  => 'powershell',
        require   => Exec['install scoop'],
      }
    }
  }
}
