Gem::Specification.new do |s|
  s.name = "oneroster"
  s.version = "0.3.2.12"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Thomas R. Koll", "Petar Risteski", "Filip Josimovski"]
  s.date = "2016-10-28"
  s.description = "Provides a ruby interface to Infinite Campus OneRoster API"
  s.summary = "Provides a ruby interface to Infinite Campus OneRoster API"
  s.email = "tomk@naiku.net"
  s.extra_rdoc_files = [
  ]
  s.add_dependency 'flexirest'
  s.add_dependency 'addressable'
  s.files = [
    "Gemfile",
    "LICENSE",
    "lib/oneroster.rb",
    "lib/oneroster/apibase.rb",
    "lib/oneroster/endpoints.rb",
    "oneroster.gemspec"
    ]
end
