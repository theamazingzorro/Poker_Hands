require_relative './hand'

class Game
  attr_accessor :black_name
  attr_accessor :black
  attr_accessor :white_name
  attr_accessor :white

  attr_accessor :winner

  SCORES = {
    high: 1,
    pair: 2,
    two_pair: 3,
    three_kind: 4,
    straight: 5,
    flush: 6,
    full_house: 7,
    four_kind: 8,
    straight_flush: 9
  }

  def initialize(game_arr)
    @black_name = game_arr[0].dup
    @black_name[':'] = ''
    @black = Hand.new game_arr[1, 5]

    @white_name = game_arr[6].dup
    @white_name[':'] = ''
    @white = Hand.new game_arr[7, 12]

    @winner = find_winner
  end

  def find_winner
    black_score = SCORES[@black.rank]
    white_score = SCORES[@white.rank]

    if black_score > white_score
      :black
    elsif black_score < white_score
      :white
    else
      tiebreaker_winner
    end
  end

  def tiebreaker_winner
    black_val_counts = @black.valueCounts
    white_val_counts = @white.valueCounts

    result = :tie
    (1..4).reverse_each do |i|
      result = result == :tie ? best_set_of(i, black_val_counts, white_val_counts) : result
    end

    result
  end

  private def best_set_of(i, black_val_counts, white_val_counts)
    black_sets = black_val_counts.select { |_, count|  count == i} .keys.sort.reverse
    white_sets = white_val_counts.select { |_, count|  count == i} .keys.sort.reverse

    black_sets.zip(white_sets).each do |black_card, white_card|
      if black_card > white_card
        return :black
      elsif black_card < white_card
        return :white
      end
    end

    :tie
  end

  def to_str
    if @winner == :black
      "Black wins. - with " + @black
    elsif @winner == :white
      "White wins. - with " + @white
    else
      "Tie."
    end
  end
end