Facter.add("scoop") do
  confine :osfamily => :windows
  setcode do
    buckets = Facter::Core::Execution.exec("scoop bucket list").split(/\r?\n/)
  
    package_list = Facter::Core::Execution.exec("scoop export").split(/\r?\n/)
        
    packages = {}
    package_list.each do |line|        
      name, version, bucket, _ignore = line.strip.split(' ')
      packages[name] = {
        name: name,
        version: version,
        bucket: bucket.gsub(/[\[\]]/)
      }
      end

      {
        buckets: buckets,
        packages: packages,
      }
  end
end
