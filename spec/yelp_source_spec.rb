require File.join(File.dirname(__FILE__), "spec_helper")

describe Burgatron::Sources::Yelp do

  subject do
    Burgatron::Sources::Yelp.new(
      yelp_config: YELP_CONFIG 
    )
  end

  it "should return processed results" do
    VCR.use_cassette('yelp-results') do
      destinations = subject.retrieve(count:     20,
                       latitude:  45.504620,
                       longitude: -122.654206)
      destinations.first.name.should == "Ford Food and Drink" # since the lat/lng are right on top of it
    end
  end
end

