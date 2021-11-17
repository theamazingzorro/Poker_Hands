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
    @black_name = game_arr[0]
    @black_name[':'] = ''
    @black = Hand.new game_arr[1, 5]

    @white_name = game_arr[6]
    @white_name[':'] = ''
    @white = Hand.new game_arr[7, 12]

    find_winner
  end

  private def find_winner
    black_score = SCORES[@black.rank]
    white_score = SCORES[@white.rank]

    if black_score > white_score
      @winner = :black
    elsif black_score < white_score
      @winner = :white
    else
      @winner = tiebreaker_winner
    end
  end

  private def tiebreaker_winner
    :white
  end
end
