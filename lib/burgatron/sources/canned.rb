require 'burgatron/destination'
require 'pry'

module YAML
  class << self
    alias_method :load, :unsafe_load
  end
end

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
