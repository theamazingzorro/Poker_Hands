require './card'

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

  def to_str
    high_card = @cards.sort_by { |card| card.val }.reverse[0]
    value_counts = valueCounts

    case rank
    when :straight_flush
      "straight flush: " + high_card
    when :four_kind
      quad_val = value_counts.key(4)
      card = @cards.find { |card| card.val == quad_val }
      "four of a kind: " + card
    when :full_house
      trio_val = value_counts.key(3)
      trio_card = @cards.find { |card| card.val == trio_val }
      pair_val = value_counts.key(2)
      pair_card = @cards.find { |card| card.val == pair_val }

      "full house: #{trio_card.to_str} over #{pair_card.to_str}"
    when :flush
      "flush: " + high_card
    when :straight
      "straight: " +high_card
    when :three_kind
      trio_val = value_counts.key(3)
      card = @cards.find { |card| card.val == trio_val }
      "three of a kind: " + card
    when :two_pair
      pair_vals = value_counts.select { |_, count| count == 2 } .keys.sort.reverse
      cards[0] = @cards.find { |card| card.val == pair_vals[0] }
      cards[1] = @cards.find { |card| card.val == pair_vals[1] }
      "two pair: #{cards[0].to_str} over #{cards[1].to_str}"
    when :pair
      pair_val = value_counts.key(2)
      card = @cards.select { |card| card.val == pair_val }
      "pair: " + card
    when :high
      "high card: " + high_card
    end
  end
end