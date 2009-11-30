module Geokit
  module Cached
    module Geocodable

      def self.included(base)
        base.class_eval do
          attr_accessor :provider
        end
      end

      def multi_geocoder
        if cache_locations?
          Geokit::Geocoders::CachedMultiGeocoder
        else
          Geokit::Geocoders::MultiGeocoder
        end
      end

      def complete_address
        "%s, %s" % [address, country]
      end

      def geocode_address_cached
        @geo = multi_geocoder.geocode(complete_address)
        self.lat, self.lng, self.provider, self.city = @geo.lat, @geo.lng, @geo.provider, @geo.city if @geo.success
      end

      def cache_locations?
        self.class::CACHE_LOCATIONS
      end

      def cached_location
        CachedLocation.find_by_address(complete_address) || CachedLocation.new(:address => complete_address)
      end

      def cache_location!
        cached_location.cache!(:lat => lat, :lng => lng, :provider => provider, :city => city) if cache_locations?
      end

    end
  end
end
