Gem::Specification.new do |s|
  s.name        = 'elominati'
  s.version     = '0.0.1'
  s.date        = '2015-03-21'
  s.summary     = 'A gem to do ELO calculations for n player games'
  s.description = 'The primary intention of this gem is to be a flexible ' +
                  'ELO calculator for multiplayer games. There isn\'t any ' +
                  'attempt at persistance simply providing the means to do ' +
                  'the ELO calculations for an individual game session'
  s.homepage    = 'https://github.com/chrisccole/elominati'
  s.authors     = ["Chris Cole"]
  s.email       = 'chris.ca.cole@gmail.com'
  s.license     = 'MIT'

  s.files         = `git ls-files -z`.split("\x0")
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]
end