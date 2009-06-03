# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './lib/geokit.rb'

# undefined method `empty?' for nil:NilClass
# /Library/Ruby/Site/1.8/rubygems/specification.rb:886:in `validate' 
class NilClass
  def empty?
    true
  end
end 

project=Hoe.new('geokit', Geokit::VERSION) do |p|
  #p.rubyforge_name = 'geokit' # if different than lowercase project name
  p.developer('Andre Lewis', 'andre@earthcode.com', 'pr0d1r2@gmail.com')
  p.summary="Geokit provides geocoding and distance calculation in an easy-to-use API with caching in MultiGeocoder"
end


# vim: syntax=Ruby
