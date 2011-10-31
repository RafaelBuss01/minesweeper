require "spec_helper"

describe "input/output" do

  before(:each) do
    #@field = mock(Field).as_null_object
    @field = Field.new(2,2)
    Field.stub!(:new).and_return(@field)
    $stdout.stub!(:puts)
  end

  it "should create field if dimension is not 0x0" do
    $stdin.stub!(:readline).and_return('1 1', '.', '0 0')
    Field.should_receive(:new).with(1, 1);
    solve
  end

  it "should stop when the field dimension when is 0x0" do
    $stdin.stub!(:readline).and_return('0 0')
    Field.should_not_receive(:new)
    solve
  end

  it "should process multiples fields" do
    $stdin.stub!(:readline).and_return('1 1', '.', '2 2', '..', '..', '0 0')
    Field.should_receive(:new).with(1, 1).ordered;
    Field.should_receive(:new).with(2, 2).ordered;
    solve
  end

  it "should add bombs" do
    $stdin.stub!(:readline).and_return('2 2', '*.', '.*', '0 0')

    @field.should_receive(:bomb_at).with(0, 0).ordered
    @field.should_receive(:bomb_at).with(1, 1).ordered

    solve
  end

  it "should solve problem" do
    $stdin.stub!(:readline).and_return('2 2', '*.', '.*', '0 0')
    @field.should_receive(:solve!)
    solve
  end

  it "print solution" do
    $stdin.stub!(:readline).and_return('2 2', '*.', '.*', '0 0')

    $stdout.should_receive(:puts).with("*2\n2*").ordered
    solve
  end

end
