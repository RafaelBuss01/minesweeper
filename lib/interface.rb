require 'rubygems'
require 'shoes'
require 'field'

Shoes.app :width => 730, :height => 450, :title => 'Minesweeper' do
	CELL_SIZE = 20
	MINE = "../images/mine.png"
	BOMB = "../images/bomb.png"
	OPEN = "../images/open.png"
	def draw_game
		clear do
      background rgb(10, 200, 90, 0.7)
      flow :margin => 4 do
				button("meclique") do 
					alert("tu o fizestes") 
				end	
				sair = button("sair") { close }
      end
      draw_postions
    end
	end

	def draw_postions
    0.upto @game.m-1 do |y|
   		0.upto @game.n-1 do |x|
    		if @game[x, y] == "." || @game[x, y] == "*"
    			draw_cell(x, y)
    		elsif @game[x, y] == " "
    			draw_open(x, y)
    		elsif @game[x, y] == "'"
    			draw_bomb(x, y)
    		end	
  			para "\n" if x == @game.m-1
      end
    end
  end

  def draw_cell(x, y)
  	image	"#{MINE}"
	end	

  def draw_bomb(x, y)
  	image	"#{BOMB}"
	end	

  def draw_open(x, y)
  	image	"#{OPEN}"
	end	

	# @interface = Interface.new Field.new 2, 2
	@game = Field.new 8, 8
	@game.bomb_at 1, 1
	@game.bomb_at 2, 1
	@game.bomb_at 2, 2
	@game.bomb_at 6, 5
	@game.bomb_at 5, 6
	@game.bomb_at 4, 7
	@game.bomb_at 3, 3

	draw_game

	@game.open 1, 1
	@game.open 2, 1
	@game.open 1, 2
	@game.open 2, 2
	@game.open 5, 7
	@game.open 6, 5
	@game.open 1, 6
	@game.open 1, 7
	@game.open 3, 3

	draw_game
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