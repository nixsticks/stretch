class WildCard
  attr_accessor :rows, :columns

  def initialize
    @rows = []
    @columns = []
  end

  def set_rows_columns
    File.readlines('./input_file.txt').each do |line|
      @rows << line.chomp.split(//)
    end

    @columns = @rows.transpose
  end

  # gets total open spots in each row
  def get_open_spots(arrays)
    open_spots = []
    arrays.each do |array|
      container = [] 
      array.each {|item| container << item if item == "*"}
      open_spots << container
    end
    open_spots
  end

  #gets permutations for open spots
  def arrangements(open_spots)
    arrangements = 0
    open_spots.each do |array|
      arrangements += array.permutation(5).to_a.size
    end
    arrangements
  end

  #get the answer
  # def get_answer
  #   set_rows_columns
  #   row_opens = get_open_spots(self.rows)
  #   column_opens = get_open_spots(self.columns)
  #   arrangements(row_opens) + arrangements(column_opens)
  # end
end

card = WildCard.new
card.set_rows_columns

#answer was 167160
row_opens = card.get_open_spots(card.rows)
column_opens = card.get_open_spots(card.columns)
p (card.arrangements(row_opens) + card.arrangements(column_opens))