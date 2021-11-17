require 'rspec'
require '../card'

describe 'Card.suit' do
  it 'has the suit "hearts"' do
    card = Card.new '2H'
    expect(card.suit).to eq :hearts
  end
  it 'has the suit "diamonds"' do
    card = Card.new '2D'
    expect(card.suit).to eq :diamonds
  end
  it 'has the suit "clubs"' do
    card = Card.new '2C'
    expect(card.suit).to eq :clubs
  end
  it 'has the suit "spades"' do
    card = Card.new '2S'
    expect(card.suit).to eq :spades
  end

  it 'has the numeric values' do
    (2..9).each do |i|
      card = Card.new "#{i}S"
      expect(card.val).to eq i
      end
  end
  it 'has the value of A = 1' do
    card = Card.new "AS"
    expect(card.val).to eq 1
  end
  it 'has the value of T = 10' do
    card = Card.new "TS"
    expect(card.val).to eq 10
  end
  it 'has the value of J = 11' do
    card = Card.new "JS"
    expect(card.val).to eq 11
  end
  it 'has the value of Q = 12' do
    card = Card.new "QS"
    expect(card.val).to eq 12
  end
  it 'has the value of K = 13' do
    card = Card.new "KS"
    expect(card.val).to eq 13
  end
end
