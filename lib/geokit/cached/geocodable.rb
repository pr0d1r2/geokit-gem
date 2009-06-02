module Geokit
  module Cached
    module Geocodable

      def self.included(base)
        base.class_eval do
          attr_accessor :provider
        end
      end

      def geocoder
        if cache_locations?
          Geokit::Geocoders::CachedMultiGeocoder
        else
          Geokit::Geocoders::MultiGeocoder
        end
      end

      def geocode_address_cached
        @geocoder.geocode(complete_address)
        self.lat, self.lng, self.provider = @geo.lat, @geo.lng, @geo.provider if @geo.success
      end

      def cache_location!
        cached_location.cache!(:lat => lat, :lng => lng, :provider => provider) if cache_locations?
      end

      def cache_locations?
        self.class::CACHE_LOCATIONS
      end

    end
  end
end