# A friend of mine runs a company called Wildcard.  I recently did their wildcard challenge and it was a lot of fun and a I think would be a good excercise to really stretch your Ruby skills.
 
# http://www.trywildcard.com/challenge
 
# Create a repo called stretch in your github.
# Create a folder called wildcard in that repo.
# Create folders in wildcard called problem1 and problem2.
 
# You'll most likely need to use classes to do this although I know at least problem 1 can be solved without.
# This will test your knowledge of string manipulation, objects and mainly iteration.
# I wrote a unit test suite for both of my answers and used mocking and stubbing extensively.
# We haven't taught a lot of these concepts but if you'd like to go as far as you can go and teach yourself some things 
# give this a shot.
 
# You can see my solutions and specs at https://github.com/blake41/wildcard
# Obviously you won't get much out of this if you just copy me, but if you are lost
# it might give you an idea of the direction to go.
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