class Interface
	attr_accessor :field
	def initialize field
		# @field = []
		@field = field
	end	

	def print_field
		@field.cells.each do |row|
			row.each do |cell|
				print cell
			end	
			puts
		end	
	end	

	
end