# @summary Installs or uninstalls Scoop

class scoop::install {
  $tester = 'try { if(Get-Command scoop) { exit 1 } } catch { exit 0 }'

  case $scoop::ensure {
    'absent': {
      Scoop::Package <| |> -> Scoop::Bucket <| |>
      -> exec { 'uninstall scoop':
        command  => 'scoop uninstall scoop',
        unless   => $tester,
        provider => 'powershell',
      }
    }
    default: {
      exec { 'install scoop':
        command  => file('scoop/install.ps1'),
        onlyif   => $tester,
        provider => 'powershell',
      }
      -> Scoop::Bucket <| |> -> Scoop::Package <| |>
    }
  }
}
