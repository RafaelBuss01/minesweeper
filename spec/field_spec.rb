require "field"

describe Field do

  it "should have MxN cells" do
    Field.new(4,4).size.should == [4,4]
    Field.new(3,2).size.should == [3,2]
  end

  it "should not create Field with invalid size" do
    proc{ Field.new(-1,2) }.should raise_error "Invalid size"
    proc{ Field.new(1,-2) }.should raise_error "Invalid size"
  end

  it "should initialize the Field with emptys cells" do
    field = Field.new(2,2)
    field[0,0].should == '.'
    field[0,1].should == '.'
    field[1,0].should == '.'
    field[1,1].should == '.'
  end

  it "should allow placement of bombs" do
    field = Field.new(3,3)
    field.bomb_at(1,1)
    field[1,1].should == '*'
  end

  describe "neighbours" do
    it "should not include itself" do
      field = Field.new(3,3)
      field.neighbours_of(1,1).should_not include([1,1])
    end

    it "should detect neighbours of a cell in the middle" do
      field = Field.new(3,3)

      field.neighbours_of(1,1).should have(8).neighbours
      field.neighbours_of(1,1).should include([0,0],[0,1],[0,2],
                                              [1,0],      [1,2],
                                              [2,0],[2,1],[2,2]
                                              )
    end

    it "should eliminate neighbours outside of the Field (negative)" do
      field = Field.new(3,3)

      field.neighbours_of(0,0).should have(3).neighbours
      field.neighbours_of(0,0).should include(      [0,1],
                                              [1,0],[1,1])
    end

    it "should eliminate neighbours outside of the Field (positive)"
  end

end
