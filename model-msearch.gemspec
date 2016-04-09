Gem::Specification.new do |s|
  s.name        = 'model-msearch'
  s.version     = '0.0.0'
  s.date        = '2015-04-09'
  s.summary     = "msearch wrapper for Elasticsearch::Model"
  s.description = "msearch wrapper for Elasticsearch::Model"
  s.authors     = ["Liam P. White"]
  s.email       = 'example@example.com'
  s.files       = ["lib/msearch-model.rb"]
  s.homepage    = 'http://example.com'
  s.license     = 'MIT'

  s.add_runtime_dependency 'elasticsearch-model', ['~> 0.1']
end
