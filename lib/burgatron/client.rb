class Burgatron::Client

  def initialize
    @sources = []
  end

  def add_source(source)
    @sources << source
  end

  def retrieve(opts={})
    opts[:count] ||= 20

    (sort coalesce results opts)[0, opts[:count]]
  end

  private

  def results(opts)
    @sources.map{|source|
      source.retrieve(opts)
    }
  end

  def coalesce(sets)
    sets.flatten.group_by(&:name).values.map{|set| set.inject(&:merge) }
  end

  def sort(set)
    set.sort_by(&:distance)
  end

end
