require 'burgatron/destination'
require 'pry'

module Burgatron
  
  module Sources
  
    class Canned

      def initialize(keyw)
        path = keyw.fetch(:path)
        @results = YAML.load File.read path
      end

      def retrieve(opts)
        @results
      end

    end

  end

end
