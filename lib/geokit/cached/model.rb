module Geokit
  module Cached
    module Model

      def self.included(base)
        base.class_eval do
          validates_presence_of :address
          validates_presence_of :lat
          validates_presence_of :lng
          validates_numericality_of :lat
          validates_numericality_of :lng
        end
      end

      def cache!(attributes)
        self.attributes = attributes
        self.city = convert_to_utf8(self.city)
        save if new_record? || changed?
      end

      def update!
        if !by_google? && geo.success
          self.lat, self.lng, self.provider, self.city = geo.lat, geo.lng, geo.provider, convert_to_utf8(geo.city)
          save if changed?
        end
      end

      def update_and_return!
        update!
        geoloc
      end

      def geo
        @geo ||= Geokit::Geocoders::MultiGeocoder.geocode(address)
      end

      def fake_geoloc
        geoloc = Geokit::GeoLoc.new
        geoloc.lat, geoloc.lng, geoloc.provider, geoloc.city, geoloc.success = lat, lng, provider, city, success?
        geoloc
      end

      def successful_geoloc
        geo if geocoding_occured? && geo.success
      end

      def geoloc
        successful_geoloc || fake_geoloc
      end

      def by_google?
        provider == 'google'
      end

      def changed_to_google?
        by_google? && provider_changed?
      end

      def changed?
        lat_changed? || lng_changed? || changed_to_google? || city_changed?
      end

      def geocoding_occured?
        !@geo.nil?
      end

      def success?
        !!(lat and lng)
      end

      def convert_to_utf8(str)
        begin
          Iconv.new('UTF-8', 'UTF-8').iconv(str)
        rescue Iconv::Failure => iconv_exception
          Iconv.new('UTF-8', 'ISO-8859-1').iconv(str)
          iconv_exception.success
        end
      end

    end
  end
end
