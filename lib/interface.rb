require 'rubygems'
require 'shoes'
require 'field'

Shoes.app :width => 730, :height => 450, :title => 'Minesweeper' do
	CELL_SIZE = 22
	MINE = "../images/mine.png"
	BOMB = "../images/bomb.png"
	OPEN = "../images/open"
	def draw_game
		clear do
      background rgb(10, 200, 90, 0.7)
		  if @game.crash?
				@game.each_cell do |cell, x, y|
					@game.open!(x, y)
				end
		  end
      draw_field
      flow :margin => 4 do
				button("quero bis") do 
					clear
      		background rgb(10, 200, 90, 0.7)
					para "digite a largura e a altura:"
					m, n = edit_line, edit_line
					button("vai!") do
						puts m.text.to_i, n.text.to_i
						@game = Field.new(m.text.to_i, n.text.to_i)
						puts @game.cells.length
						draw_game
					end	
				end	
				button("sair") { close }
      end
    end
	end

	def draw_field
		para "\n  "
    0.upto @game.m-1 do |y|
   		0.upto @game.n-1 do |x|
    		if @game[x, y] == "." || @game[x, y] == "*"
    			draw_cell(x, y)
    		elsif @game[x, y] == " "
    			draw_open(x, y)
    		elsif @game[x, y] == "'"
    			draw_bomb(x, y)
    		end	
  			# para "\n " if x == @game.m-1
      end
      para "\n  " 
    end
  end

  def draw_cell(x, y)
  	image	"#{MINE}"
	end	

  def draw_bomb(x, y)
  	image	"#{BOMB}"
	end	

  def draw_open(x, y)
  	# para "#{OPEN}#{n}.png"
  	image	"#{OPEN}#{@game.bombs_around(x, y)}.png"
	end	

	# @interface = Interface.new Field.new 2, 2
	@game = Field.new 8, 8
	@game.bomb_at 2,1
	@game.bomb_at 3,1
	@game.bomb_at 4,1
	@game.bomb_at 5,1
	@game.bomb_at 2,2
	@game.bomb_at 2,3
	@game.bomb_at 2,4
	@game.bomb_at 2,5
	@game.bomb_at 3,5
	@game.bomb_at 4,5
	@game.bomb_at 5,5
	@game.bomb_at 5,4
	@game.bomb_at 5,3
	@game.bomb_at 4,3
	@game.bomb_at 0,0
	@game.bomb_at 0,7
	@game.bomb_at 7,0
	@game.bomb_at 7,7

	draw_game
	m, n = 0, 0
  click do |button, x, y|

	  fx = ((x-(self.width - @game.m*CELL_SIZE.to_i) / 2) / CELL_SIZE).to_i + 12
	  fy = ((y-(self.height - @game.n*CELL_SIZE.to_i) / 2) / CELL_SIZE).to_i + 5
	 	# fx = 
	 	if button == 1
	  	puts "#{x}:#{fx},#{y}:#{fy}"
	  	@game.select!(fx, fy)
	  end
	  # n +=1 if button == 3
	  # m, n = 0, 0 if button == 2
	  # puts "#{x}:#{fx},#{y}:#{fy}"
	  draw_game
  end











	# draw_game

	# @game.open 1, 1
	# @game.open 2, 1
	# @game.open 1, 2
	# @game.open 2, 2
	# @game.open 5, 7
	# @game.open 6, 5
	# @game.open 1, 6
	# @game.open 1, 7
	# @game.open 3, 3

end


# Shoes.app :width => 730, :height => 450, :title => 'Minesweeper'






class Interface
	attr_accessor :field
	def initialize game
		@game = game
	end	
end
# 	def print_field
# 		@field.cells.each do |row|
# 			row.each do |cell|
# 				print cell
# 			end	
# 			puts
# 		end	
# 	end	

# end