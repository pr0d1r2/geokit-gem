module Geokit
  module Geocoders
    class CachedMultiGeocoder

      class << self

        def cached_location(location)
          CachedLocation.find_by_address(location) || CachedLocation.new(:address => location)
        end

        def geocode(location)
          cached_location(location).update_and_return!
        end
      
      end

    end
  end
end
