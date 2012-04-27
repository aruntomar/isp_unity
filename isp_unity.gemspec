# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "isp_unity/version"

Gem::Specification.new do |s|
  s.name        = "ispunity"
  s.version     = "0.0.3" 
  s.authors     = ["Pratik Shah", "Siva Gollapalli", "Arun Tomar"]
  s.email       = ["pratik14shah@gmail.com", "sivagollapalli@yahoo.com", "arun@solutionenterprises.co.in"]
  s.homepage    = "http://www.ispunity.com"
  s.summary     = %q{IspUnity is a open source framework, build to integrate (load balance & failover) multiple internet connections simultaneously}
  s.description = %q{With IspUnity, you can 1.Use multiple internet connections simultaneously and get all their throughput. 2.Automatic failover on working net connection if any on of the internet connection goes down.}
  s.add_dependency("log4r", "~> 1.1.10")
  s.add_dependency("i18n")
  s.add_dependency("json")


  s.rubyforge_project = "ispunity"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
