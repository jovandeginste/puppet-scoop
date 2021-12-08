# How to test your code

To test your code while referencing the scoop module, you need to add a number of facts to your test suite:

```ruby
let(:facts) do
  os_facts.merge(
    'scoop'        => {
      'exec'       => 'c:\\programdata\\scoop\\shims\\scoop',
      'basedir'    => 'c:\\programdata\\scoop',
      'buckets'    => [
        'main'
      ],
      'packages'   => {
        'git'      =>
        {
          'name'    => 'git',
          'version' => '2.33.1.windows.1',
          'bucket'  => 'main',
          'global'  =>  true,
        }
      }
    }
  )
end
```

This allows you to run tests such as:

```ruby
it {
    is_expected.to contain_scoop__package('7zip').with('ensure' => 'present')
}
```

given the following in your manifest:

```puppet
scoop::package { '7zip':
  ensure => 'present',
}
```
