class Field
  def initialize(m, n)
    raise "Invalid size" unless m > 0 && n > 0
    @m, @n = m, n
    @cells = Array.new
    @m.times { |row| @cells[row] = ['.'] * @n }
  end

  def size
    [@m,@n]
  end

  def [](m, n)
    @cells[m][n]
  end

  def bomb_at(m, n)
    @cells[m][n] = '*'
  end

  def neighbours_of(m,n)
    neighbours = []
    (-1..1).each do |r|
      (-1..1).each do |c|
        next if r == 0 && c == 0
        neighbour_x, neighbour_y = m+r, n+c
        next if neighbour_x < 0 || neighbour_y < 0
        neighbours << [neighbour_x, neighbour_y]
      end
    end
    neighbours
  end
end
