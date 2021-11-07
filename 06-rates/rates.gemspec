Gem::Specification.new do |s|
  s.name = 'rates'
  s.version = '0.1.0'
  s.summary = '6th homework for NI-RUB, utility to convert currencies'
  s.authors = ['Jan Štefánik']
  s.email = 'jan.stefanik97@gmail.com'
  s.files = Dir.glob("{lib,bin}/**/*") # add everything in lib and bin
  s.require_path = 'lib'
  s.license = 'MIT'
  s.executables = ['rates']
  s.add_runtime_dependency 'http'
  s.add_runtime_dependency 'thor'

end
