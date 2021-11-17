require 'rspec'
require '../hand'

describe 'PokerHand' do
  it 'initializes cards to be a list of 5 cards' do
    hand = Hand.new %w[2H 3D 5S 9C KD]
    hand.cards.each do |card|
      expect(card.class).to eq Card.new('2h').class
    end

    expect(hand.cards.length).to eq 5
  end
end

describe 'PokerHand.valueCounts' do
  it 'counts 4 - 1 split' do
    hand = Hand.new %w[2H 2D 2S 2C KD]
    val_counts = hand.valueCounts

    expect(val_counts[2]).to eq 4
    expect(val_counts[13]).to eq 1

    expect(val_counts.size).to eq 2
  end
  it 'counts 3 - 2 split' do
    hand = Hand.new %w[2H 2D 2S 9C 9D]
    val_counts = hand.valueCounts

    expect(val_counts[2]).to eq 3
    expect(val_counts[9]).to eq 2

    expect(val_counts.size).to eq 2
  end
  it 'counts 3 - 1 - 1 split' do
    hand = Hand.new %w[2H 2D 2S 6C 8D]
    val_counts = hand.valueCounts

    expect(val_counts[2]).to eq 3
    expect(val_counts[6]).to eq 1
    expect(val_counts[8]).to eq 1

    expect(val_counts.size).to eq 3
  end
  it 'counts 2 - 2 - 1 split' do
    hand = Hand.new %w[2H 2D 6S 6C 8D]
    val_counts = hand.valueCounts

    expect(val_counts[2]).to eq 2
    expect(val_counts[6]).to eq 2
    expect(val_counts[8]).to eq 1

    expect(val_counts.size).to eq 3
  end
  it 'counts 2 - 1 - 1 - 1 split' do
    hand = Hand.new %w[2H TD 6S 6C 8D]
    val_counts = hand.valueCounts

    expect(val_counts[2]).to eq 1
    expect(val_counts[6]).to eq 2
    expect(val_counts[8]).to eq 1
    expect(val_counts[10]).to eq 1

    expect(val_counts.size).to eq 4
  end
  it 'counts 5 unique' do
    hand = Hand.new %w[aH jD tS qC KD]
    val_counts = hand.valueCounts

    expect(val_counts[1]).to eq 1
    expect(val_counts[10]).to eq 1
    expect(val_counts[11]).to eq 1
    expect(val_counts[12]).to eq 1
    expect(val_counts[13]).to eq 1

    expect(val_counts.size).to eq 5
  end
end

describe 'PokerHand.flush?' do
  it 'returns true for a flush' do
    hand = Hand.new %w[2H 2h 2h 2H Kh]
    expect(hand.flush?).to eq true
  end

  it 'returns false for a non flush' do
    hand = Hand.new %w[2H 2D 2S 2C KD]
    expect(hand.flush?).to eq false
  end
end

describe 'PokerHand.straight?' do
  it 'returns true for 5 consecutive cards' do
    hand = Hand.new %w[2H 3h 4h 5H 6d]
    expect(hand.straight?).to eq true
  end

  it 'returns false for 5 non consecutive cards' do
    hand = Hand.new %w[2H 2D 2S 2C KD]
    expect(hand.straight?).to eq false
    expect(hand.straight?).to eq false
  end
end

describe 'PokerHand.rank' do
  it 'outputs :high for a high card hand' do
    hand = Hand.new %w[2H 3D 5S 9C KD]
    expect(hand.rank).to be :high
  end

  it 'outputs :pair for a hand with 1 pair and nothing else' do
    hand = Hand.new %w[2H 2D 5S 9C KD]
    expect(hand.rank).to be :pair
  end

  it 'outputs :two_pair for a hand with two pairs and nothing else' do
    hand = Hand.new %w[2h 2d 5c js 5s]
    expect(hand.rank).to be :two_pair
  end

  it 'outputs :three_kind for a hand with three of a kind and nothing else' do
    hand = Hand.new %w[2h 2d 2c js 5s]
    expect(hand.rank).to be :three_kind
  end

  it 'outputs :straight for a hand with 5 consecutive values' do
    hand = Hand.new %w[2h 3d 4c 5s 6s]
    expect(hand.rank).to be :straight
  end

  it 'outputs :flush for a hand with all the same suit' do
    hand = Hand.new %w[2h ah 5h jh 4h]
    expect(hand.rank).to be :flush
  end

  it 'outputs :full_house for a hand with three of a kind and a pair' do
    hand = Hand.new %w[2h 2d 5c 5d 5s]
    expect(hand.rank).to be :full_house
  end

  it 'outputs :full_house for a hand with three of a kind and a pair all the same suit' do
    hand = Hand.new %w[2s 2s 5s 5s 5s]
    expect(hand.rank).to be :full_house
  end

  it 'outputs :four_kind for a hand with four of a kind' do
    hand = Hand.new %w[2h 5d 5c 5s 5s]
    expect(hand.rank).to be :four_kind
  end

  it 'outputs :four_kind for a hand with four of a kind all the same suit' do
    hand = Hand.new %w[2s 5s 5s 5s 5s]
    expect(hand.rank).to be :four_kind
  end

  it 'outputs :straight_flush for a hand with all consecutive values of one suit' do
    hand = Hand.new %w[2h 3h 4h 5h 6h]
    expect(hand.rank).to be :straight_flush
  end
end
