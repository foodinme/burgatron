require 'bundler/setup'
require 'rspec'
require 'burgatron'
require 'vcr'
require 'webmock'

YELP_CONFIG = {
  consumer_key:    ENV['YELP_CONSUMER_KEY'],
  consumer_secret: ENV['YELP_CONSUMER_SECRET'],
  token:           ENV['YELP_TOKEN'],
  token_secret:    ENV['YELP_TOKEN_SECRET'],
}

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr'
  c.hook_into :webmock
  YELP_CONFIG.each do |key, val|
    c.filter_sensitive_data("<#{key}>".upcase) { val }
  end
end
