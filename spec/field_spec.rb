require "field"

describe Field do

  it "should have MxN cells" do
    Field.new(4,4).size.should == [4,4]
    Field.new(3,2).size.should == [3,2]
  end

end
