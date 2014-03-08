require File.join(File.dirname(__FILE__), "spec_helper")

describe Burgatron::Sources::Foursquare do

  subject do
    Burgatron::Sources::Foursquare.new(
      foursquare_config: FOURSQUARE_CONFIG 
    )
  end

  it "should return processed results" do
    VCR.use_cassette('fsq-results') do
      destinations = subject.retrieve(count: 20,
                       latitude:  45.504620,
                       longitude: -122.654206)
      destinations.any?{|dest|
        dest.name == "Ford Food and Drink" # since the lat/lng are right on top of it
      }.should be_true
    end
  end
end

