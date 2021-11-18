class Hand
  attr_accessor :cards

  def initialize(card_str)
    @cards = []
    card_str.each do |card|
      @cards << Card.new(card)
    end
  end

  def valueCounts
    value_counts = { }
    @cards.each do |card|
      if value_counts[card.val]
        value_counts[card.val] += 1
      else
        value_counts[card.val] = 1
      end
    end

    value_counts
  end

  def flush?
    is_flush = true
    (0..3).each do |i|
      is_flush &= cards[i].suit == cards[i+1].suit
    end

    is_flush
  end

  def straight?
    card_values = cards.collect do |card|
      card.val
    end
    card_values.sort

    is_straight = true
    (0..3).each do |i|
      is_straight &= card_values[i] + 1 == card_values[i+1]
    end
    is_straight
  end

  def rank
    value_counts = valueCounts.values

    if straight? && flush?
      :straight_flush
    elsif value_counts.max == 4
      :four_kind
    elsif value_counts.max(2) == [3, 2]
      :full_house
    elsif flush?
      :flush
    elsif straight?
      :straight
    elsif value_counts.max == 3
      :three_kind
    elsif value_counts.max(2) == [2, 2]
      :two_pair
    elsif value_counts.max == 2
      :pair
    else
      :high
    end
  end


  def ==(other)
    is_equal = true

    other.cards.each do |other_card|
      is_equal &= @cards.include?(other_card)
    end

    is_equal
  end
end