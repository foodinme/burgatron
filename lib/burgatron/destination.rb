module Burgatron

  class Destination < Struct.new(:name, :location, :categories, :source, :source_details)
    
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
