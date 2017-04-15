# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require "o_data/version"

Gem::Specification.new do |s|
  s.name = "odata_server"
  s.version = OData::VERSION
  s.authors = ["Mark Borkum", "Brad Langhorst", "Nigel Sheridan-Smith", "Lawrence McAlpin", "Jason Hamilton", "Sebastian Kliem","Nate Greene"]
  s.date = "2016-06-02"
  s.email = "lmcalpin@gmail.com"
  s.homepage = ""
  s.summary = "A simple gem that exposes ActiveRecord models as OData collections."
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
  s.require_paths = ["lib"]

  s.add_dependency "rails", ">= 4.0"
end
