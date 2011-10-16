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
        next if neighbour_x >= @m || neighbour_y >= @n
        neighbours << [neighbour_x, neighbour_y]
      end
    end
    neighbours
  end

  def each_cell(&blk)
    @cells.each_with_index do |row, x|
      row.each_with_index do |cell, y|
        blk.call(cell, x, y)
      end
    end
  end

  def solve!
    replace_dots_with_zero

    each_cell do |cell, x,y|
      next if cell != '*'
      neighbours_of(x,y).each do |neighbour_x, neighbour_y|
        @cells[neighbour_x][neighbour_y] += 1 unless @cells[neighbour_x][neighbour_y]  == '*'
      end
    end
  end

  def to_a
    @cells.map do |row|
      row.join
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
