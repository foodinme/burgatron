require File.join(File.dirname(__FILE__), "spec_helper")

describe Burgatron::Client do

  subject { Burgatron::Client.new }
  let(:test_source) do
    double('test-source')
  end

  before do
    subject.add_source test_source
  end

  it "should retrieve destinations from each source" do
    test_source.should_receive(:retrieve).with(count: 20).and_return(
      [ Burgatron::Destination.new("Sausage King") ]
    )
    destinations = subject.retrieve(count: 20)
    destinations.first.name.should == "Sausage King"
  end

  it "should interleave destinations" do
    test_source.should_receive(:retrieve).and_return(
      [ 
        Burgatron::Destination.new("Sausage King"),
        Burgatron::Destination.new("Taco Hut"),
        Burgatron::Destination.new("Uncle Joe's Borschtasia")
      ]
    )
    source2 = double('test-source-2')
    source2.should_receive(:retrieve).and_return(
      [ 
        Burgatron::Destination.new("Tofu Zone"),
        Burgatron::Destination.new("Le Canard Chanceaux"),
      ]
    )
    subject.add_source source2

    destinations = subject.retrieve(count: 4)
    destinations.should have(4).entries
    destinations.map(&:name).should == ["Sausage King", "Tofu Zone", "Taco Hut", "Le Canard Chanceaux"] 
  end

end
