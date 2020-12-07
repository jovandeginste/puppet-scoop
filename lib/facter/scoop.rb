Facter.add('scoop') do
  setcode do
    {
      buckets: [],
      packages: {},
    }
  end
end

Facter.add('scoop') do
  confine osfamily: :windows
  confine { Facter::Core::Execution.which('scoop') }

  setcode do
    buckets = Facter::Core::Execution.exec('scoop bucket list').split(%r{\r?\n})

    package_list = Facter::Core::Execution.exec('scoop export').split(%r{\r?\n})

    packages = {}
    package_list.each do |line|
      name, version, bucket, _ignore = line.strip.split(' ')
      packages[name] = {
        name: name,
        version: version,
        bucket: bucket.gsub(%r{[\[\]]}),
      }
    end

    {
      buckets: buckets,
      packages: packages,
    }
  end
end
