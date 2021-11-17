require 'rspec'
require '../card'

describe 'Card' do
  describe 'suit' do
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
  end
  describe 'value' do
    it 'has the numeric values' do
      (2..9).each do |i|
        card = Card.new "#{i}S"
        expect(card.val).to eq i
        end
    end
    it 'has the value of A = 14' do
      card = Card.new "AS"
      expect(card.val).to eq 14
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

  describe '==' do
    it 'returns true if the suit and value are the same' do
      card1 = Card.new "4H"
      card2 = Card.new "4H"

      expect(card1).to eq card2
    end

    it 'returns false if the suits are different' do
      card1 = Card.new "4H"
      card2 = Card.new "4S"

      expect(card1).not_to eq card2
    end

    it 'returns false if the values are different' do
      card1 = Card.new "4H"
      card2 = Card.new "5h"

      expect(card1).not_to eq card2
    end
  end
end