require 'foursquare2'
require 'burgatron/destination'

module Burgatron
  
  module Sources
  
    class Foursquare
      
      CategoryMapping = {
        "Café"               => :cafe,
        "Coffee Shop"        => :coffee,
        "Diner"              => :diners,
        "Grocery Store"      => :grocery,
        "Latin American"     => :latin,
        "Vegetarian / Vegan" => :vegetarian,
      }
      CategoryMapping.default_proc = ->(h,k) { k.to_s.downcase.to_sym }

      def initialize(keyw)
        @config = keyw.fetch(:foursquare_config)
      end

      def retrieve(opts)
        req = request(
          latitude:  opts.fetch(:latitude),
          longitude: opts.fetch(:longitude),
          limit:     opts.fetch(:count)
        )

        search(req)["venues"].map do |each|
          destination(each)
        end
      end

      private
      
      def client
        @client ||= Foursquare2::Client.new(@config.merge(api_version: "20140308")) 
      end

      def destination(result)
        Burgatron::Destination.new.tap do |dest|
          dest.name       = result["name"]
          loc = result["location"]
          dest.location   = loc.merge(
            geo_address:  "#{loc["address"]}, #{loc["postalCode"]}",
            geo_location: "#{loc["lat"]},#{loc["lng"]}"
          )
          dest.categories = result["categories"].map{|cat|
            CategoryMapping[cat["shortName"]]
          }
          dest.source     = "foursquare"
          dest.source_details = {}
        end
      end

      def request(opts)
        opts
      end

      def search(opts)
        ll = "#{opts[:latitude]},#{opts[:longitude]}"
        client.search_venues(
          ll: ll,
          radius: 1000,
          intent: "browse",
          categoryId: "4d4b7105d754a06374d81259" # restaurants
        )
      end

    end

  end

end
