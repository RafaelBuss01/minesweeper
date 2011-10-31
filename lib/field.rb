class Field
	attr_accessor :cells

	def initialize(m, n)
		raise "Invalid size" unless m > 0 && n > 0
		@m, @n = m, n
		@cells = []
		@m.times do |row|
			@cells[row] = ["."] * @n
		end
	end

	def size
		[@m,@n]
	end

	def [](m, n)
		@cells[m][n]
	end

	def bomb_at(m, n)
		@cells[m][n] = "*"
	end

	def each_cell(&blk)
		@cells.each_with_index do |row, x|
			row.each_with_index do |cell, y|
				blk.call(cell, x,y)
			end
		end
	end

	def neighbours_of(m,n)
		neighbours = []
		(-1..1).each do |dx|
			(-1..1).each do |dy|
				neighbour_x, neighbour_y = m+dx, n+dy
				next if dx == 0 && dy == 0
				next if neighbour_x < 0 || neighbour_y < 0
				next if neighbour_x >= @m || neighbour_y >= @n
				neighbours << [neighbour_x, neighbour_y]
			end
		end
		neighbours
	end

	def to_a
		@cells.map {|row| row.join}
	end

	def solve!
		replace_dots_with_zero
		each_cell do |cell, x, y|
			next if cell != '*'
			neighbours_of(x,y).each do |neighbour_x, neighbour_y|
				 @cells[neighbour_x][neighbour_y] += 1 unless self[neighbour_x, neighbour_y] == '*'
			end
		end
	end

private
	def replace_dots_with_zero
		@cells.map! do |row|
			row.map! do |cell|
				cell == '.' ? 0 : cell
			end
		end
	end
end

def solve
	loop do
		m, n = $stdin.readline.split.map {|x| x.to_i}
		break if m == 0 && n == 0
		field = Field.new(m, n)
		m.times do |row|
			$stdin.readline.split('').each_with_index do |char, col|
				field.bomb_at(row, col) if char == '*'
			end
		end
		field.solve!
		$stdout.puts field.to_a.join("\n")
	end
end

solve if __FILE__ == $0
