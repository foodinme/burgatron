require 'yelpster'
require 'burgatron/destination'

module Burgatron
  
  module Sources
  
    class Yelp

      def initialize(keyw)
        ::Yelp.configure keyw.fetch(:yelp_config)
      end

      def retrieve(opts)
        req = request(
          latitude:  opts.fetch(:latitude),
          longitude: opts.fetch(:longitude),
          limit:     opts.fetch(:count)
        )

        search(req)["businesses"].map do |each|
          destination(each)
        end
      end

      private
      
      def client
        ::Yelp::Client.new
      end

      def destination(result)
        Burgatron::Destination.new.tap do |dest|
          dest.name       = result["name"]
          loc = result["location"]
          dest.location   = loc.merge(
            "geo_address" => loc["address"].first + ", " + loc["postal_code"],
            "distance"    => result["distance"]
          )
          dest.categories = result["categories"].map(&:last)
          dest.source     = "yelp"
          dest.source_details = {
            "url"          => result["mobile_url"],
            "rating_img"   => result["rating_img_url_small"],
            "review_count" => result["review_count"],
          }
        end
      end

      def request(opts)
        ::Yelp::V2::Search::Request::GeoPoint.new opts.merge(
          compress_response: false,
          category_filter: %w[restaurants],
          radius_filter: 1000
        )
      end

      def search(req)
        client.search(req)
      end

    end

  end

end
