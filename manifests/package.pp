define scoop::package (
  Enum['present', 'absent'] $ensure = 'present',
) {
  $tester = "if(scoop info '${name}' | Select-String -Pattern '^Installed: No$' ) { exit 1 }"

  case $ensure {
    'absent': {
      exec { "scoop uninstall ${name}":
        command   => "scoop uninstall '${name}'",
        onlyif    => $tester,
        provider  => 'powershell',
        require   => Exec['install scoop'],
      }
    }
    default: {
      exec { "scoop install ${name}":
        command   => "scoop install '${name}'",
        unless    => $tester,
        provider  => 'powershell',
        require   => Exec['install scoop'],
      }
    }
  }
}
