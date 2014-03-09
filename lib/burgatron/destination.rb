module Burgatron

  class Destination < Struct.new(:name, :location, :categories, :source, :source_details)
    
    def initialize(*a)
      super
      self.location       ||= {}
      self.categories     ||= []
      self.source_details ||= {}
    end

    def categories=(val)
      super Burgatron::Categories.expand_all(*val)
    end

    def merge(other)
      self.class.new.tap do |merged|
        merged.name           = name
        merged.location       = other.location.merge(location)
        merged.categories     = categories | other.categories
        merged.source         = "#{source},#{other.source}"
        merged.source_details = other.source_details.merge(source_details)
      end
    end

    def distance # in meters
      location["distance"] ? location["distance"].to_f : Float::INFINITY
    end

  end

  Categories = {
    :restaurant    => [],
      :asian       => [:restaurant],
        :chinese   => [:asian],
        :japanese  => [:asian],
          :sushi   => [:japanese],
      :mexican     => [:restaurant],
        :taqueria  => [:mexican],
      :latin       => [:restaurant],
      :american    => [:restaurant],
        :burgers   => [:american],
        :diners    => [:american],
        :tradamerican => [:american],
        :newamerican  => [:american],
      :cafe        => [:restaurant],
        :coffee    => [:cafe],
      :bbq         => [:restaurant],
      :italian     => [:restaurant],
        :pizza     => [:italian],
      :desserts    => [:restaurant],
      :vegetarian  => [:restaurant],
        :vegan     => [:vegetarian],
    :retail        => [],
      :deli        => [:retail],
      :grocery     => [:retail],
      :convenience => [:retail],
        :gas       => [:convenience],
  }
  
  Categories.default = []

  def Categories.expand(name)
    name = name.to_sym
    [name] + self[name].map{|r| expand(r) }.flatten.uniq
  end

  def Categories.expand_all(*names)
    names.map do |name|
      expand name.to_sym
    end.flatten.uniq
  end

end
