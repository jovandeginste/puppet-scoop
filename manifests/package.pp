# @summary Install or uninstall a Scoop package
#
# @example Install a package
#   scoop::package { 'firefox':
#     ensure => 'present',
#   }
#
# @example Uninstall a package
#   scoop::package { 'firefox':
#     ensure => 'absent',
#   }
#
# @param ensure
#   Specifies whether to create the bucket. Valid values are 'present', 'absent'. Defaults to 'present'.
#
define scoop::package (
  Enum['present', 'absent'] $ensure = 'present',
) {
  include ::scoop::install

  $tester = "if(scoop info '${name}' | Select-String -Pattern '^Installed: No$' ) { exit 1 }"

  case $ensure {
    'absent': {
      exec { "scoop uninstall ${name}":
        command  => "scoop uninstall '${name}'",
        onlyif   => $tester,
        provider => 'powershell',
      }
    }
    default: {
      exec { "scoop install ${name}":
        command  => "scoop install '${name}'",
        unless   => $tester,
        provider => 'powershell',
      }
    }
  }
}
