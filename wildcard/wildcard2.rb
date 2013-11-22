require 'awesome_print'

class CardSet
  include Comparable
  attr_accessor :cards, :budget, :sets, :times

  def initialize
    @cards = []
    @sets = []
    @times = {}
  end

  def add_card(card)
    cards << card
  end

  def generation_times(card)
    card.generation_time
  end

  def positioning_times(card, total)
    card.overhead * (total - 1)
  end

  def total_time(i)
    sort = cards.sort_by {|card| generation_times(card) + positioning_times(card, i)}

    container = sort[0..(i-1)]
    count = 0

    container.each do |card|
      count += generation_times(card) + positioning_times(card, i)
    end

    count
  end
end

class Card
  attr_reader :generation_time, :overhead, :total

  GENERATION = [9, 10, 21, 20, 7, 11, 4, 15, 7, 7, 14, 5, 20, 6, 29, 8, 11, 19, 18, 22, 29, 14, 27, 17, 6, 22, 12, 18, 18, 30]
  OVERHEAD = [21, 16, 19, 26, 26, 7, 1, 8, 17, 14, 15, 25, 20, 3, 24, 5, 28, 9, 2, 14, 9, 25, 15, 13, 15, 9, 6, 20, 27, 22]

  def initialize(number)
    @number = number
    @generation_time = GENERATION[number]
    @overhead = OVERHEAD[number]
    @total = generation_time + overhead
  end
end

cardset = CardSet.new(Budgeter.new)

30.times do |i|
  cardset.add_card(Card.new(i))
end

ap cardset.total_time(17)