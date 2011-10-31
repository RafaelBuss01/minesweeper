require "spec_helper"

describe Field do

	it "should have MxN celss" do
		Field.new(4, 4).size.should == [4,4]
		Field.new(3, 2).size.should == [3,2]
	end

	it "should not create Field with invalid size" do
		proc {Field.new(-1, 2)}.should raise_error("Invalid size")
		proc {Field.new(2, -1)}.should raise_error("Invalid size")
	end

	it "should initialize with empty cells" do
		field = Field.new(2,2)
		field[0,0].should == "."
		field[0,1].should == "."
		field[1,0].should == "."
		field[1,1].should == "."
	end

	it "should allow placement of bombs" do
		field = Field.new(3,3)
		field.bomb_at(1,1)
		field[1,1].should == '*'
	end

	describe "(neighbourhood)" do
		before(:each) do
			@field = Field.new(3,3)
		end

		it "should not include itself" do
			@field.neighbours_of(1,1).should_not include([1,1])
		end

		it "should detect neighbours of a cell in the middle" do

			@field.neighbours_of(1,1).should have(8).neighbours

			@field.neighbours_of(1,1).should include([0,0],[0,1],[0,2],
																							[1,0],      [1,2],
																							[2,1],[2,1],[2,2]
																						 )
		end

		it "should eliminate neighbours outside of field (negative)" do
			@field.neighbours_of(0,0).should have(3).neighbours
			@field.neighbours_of(0,0).should include(    [0,1],
																						 [1,0],[1,1])

		end
		it "should eliminate neighbours outside of field (positive)" do
			@field.neighbours_of(2,1).should have(5).neighbours
			@field.neighbours_of(2,1).should include([1,0],[1,1],[1,2],
																							 [2,0],      [2,2])
		end
		it "should eliminate neighbours outside of field (positive)" do
			@field.neighbours_of(1,2).should have(5).neighbours
			@field.neighbours_of(1,2).should include([0,1],[0,2],
																							 [1,1],
																							 [2,1],[2,2])
		end

		it "should provide array representation" do
			field = Field.new(2,2)
			field.bomb_at(0,0)
			field.to_a.should == ["*.",".."]
		end
	end

	describe "(solving)" do
		before(:each) do
			@field = Field.new(2,2)
		end


		it "should allow interating over each cell and position" do
			#field = Field.new(2,2)
			# cells = [[0,0],[0,1],[1,0],[1,1]]
			# cells = [['.', 0,0],['.',0,1],['.',1,0],['.',1,1]]
			cells = {
							 [0,0] => '.',
							 [0,1] => '.',
							 [1,0] => '.',
							 [1,1] => '.'
							}

			@field.each_cell do |c, *pos|
				#cells.delete [c,x,y]
				c.should == cells[pos]
			end
			#cells.should be_empty
		end

		it "should replace the '.' for zero " do
			#field = Field.new(2,2)
			@field.solve!
			@field.to_a.should == ["00","00"]
		end

		it "should increment 1 in all bomb's neighbours" do
				#field = Field.new(2,2)
				@field.bomb_at(0,0);
				@field.solve!

				@field.to_a.should == ['*1',
																'11']
		end

		# bomb side of bomb
		it "should no increment if neighbour is a bomb" do
				@field.bomb_at(0,0);
				@field.bomb_at(0,1);
				@field.solve!

				@field.to_a.should == ['**',
															 '22']

		end
	end
end
