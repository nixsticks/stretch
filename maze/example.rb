class Puzzle

  attr_reader :cells

  Solution = [0, 1, 2, 3, 4, 5, 6, 7, 8]

  def initialize(cells)
    @cells = cells
  end

  def solution?
    Solution == @cells
  end

  def zero_position
    @cells.index(0)
  end

  def swap(swap_index)
    new_cells = @cells.clone
    new_cells[zero_position] = new_cells[swap_index]
    new_cells[swap_index] = 0
    Puzzle.new(new_cells)
  end

end

class State
  attr_reader :puzzle, :path

  Directions = [:left, :right, :up, :down]

  def initialize(puzzle, path=[])
    @puzzle, @path = puzzle, path
  end

  def solution?
    puzzle.solution?
  end

  def branches
    Directions.map{|dir| branch_toward dir}.compact.shuffle
  end

  def branch_toward(direction)
    blank_position = puzzle.zero_position
    blankx = blank_position % 3
    blanky = (blank_position/3).to_i
    cell = case direction
    when :left
      blank_position - 1 unless 0 == blankx
    when :right
      blank_position + 1 unless 2 == blankx
    when :up
      blank_position - 3 unless 0 == blanky
    when :down
      blank_position + 3 unless 2 == blanky
    end
    State.new(puzzle.swap(cell), @path + [direction]) if cell
  end
end

def search(state)
  state.branches.reject do |branch|
    @visited.include? branch.puzzle.cells
  end.each do |branch|
    @frontier << branch
  end
end

require 'set'

def solve(puzzle)
  @visited = Set.new
  @frontier = []
  state = State.new(puzzle)
  loop do
    @visited << state.puzzle.cells
    break if state.solution?
    search state
    state = @frontier.shift
  end
  state
end

p solve(Puzzle.new [7, 6, 2, 5, 3, 1, 0, 4, 8]).path