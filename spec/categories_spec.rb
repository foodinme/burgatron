require File.join(File.dirname(__FILE__), "spec_helper")

describe Burgatron::Categories do

  subject { Burgatron::Categories }

  it "should expand categories" do
    subject.expand("gas").should == [:gas, :convenience, :retail]
  end

end
