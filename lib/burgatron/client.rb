class Burgatron::Client

  def initialize
    @sources = []
  end

  def add_source(source)
    @sources << source
  end

  def retrieve(opts={})
    opts[:count] ||= 20

    interleave @sources.map{|source|
      source.retrieve(opts)
    }, opts
  end

  private

  def interleave(sets, opts)
    count = opts.fetch(:count)
    first, *rest = sets
    first.zip(*rest).flatten[0,count]
  end

end
