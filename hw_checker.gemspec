Gem::Specification.new do |s|
  s.name        = 'hw_checker'
  s.version     = '1.4.10'
  s.date        = '2013-06-21'
  s.summary     = 'Ruby-based utility to calculate hometasks'
  s.authors     = ['Lv-LAMP-085']
  s.files       = Dir['lib/**/*.rb'] + Dir['bin/*'] + Dir['spec/*'] + Dir['config/*']

  s.add_runtime_dependency 'rspec'
  s.add_runtime_dependency 'rubocop', '~> 0.8.3'
  s.add_runtime_dependency 'nokogiri'
end
