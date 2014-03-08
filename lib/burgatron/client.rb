class Burgatron::Client

  def initialize
    @sources = []
  end

  def add_source(source)
    @sources << source
  end

  def retrieve(opts={})
    opts[:count] ||= 20

    interleave(coalesce(results(opts), opts), opts)
  end

  private

  def results(opts)
    @sources.map{|source|
      source.retrieve(opts)
    }
  end

  def coalesce(sets, opts)
    first, *rest = sets
    merged_rest  = rest.map{|set| 
      set.reject{|location| 
        first.detect{|any|
          any == location
        }}}
    [first] + merged_rest
  end

  def interleave(sets, opts)
    count = opts.fetch(:count)
    first, *rest = sets
    first.zip(*rest).flatten[0,count]
  end

end
