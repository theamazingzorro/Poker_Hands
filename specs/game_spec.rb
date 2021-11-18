require 'rspec'
require '../game'

describe 'Game' do
  describe 'initialize' do
    it 'creates 2 hands' do
      game = Game.new %w[Black: 2H 3D 5S 9C KD  White: 2C 3H 4S 8C AH]
      expect(game.black).to eq Hand.new %w[2H 3D 5S 9C KD]
      expect(game.white).to eq Hand.new %w[2C 3H 4S 8C AH]
    end

    it 'saves the given names' do
      game = Game.new %w[Black: 2H 3D 5S 9C KD  White: 2C 3H 4S 8C AH]
      expect(game.black_name).to eq "Black"
      expect(game.white_name).to eq "White"
    end
  end

  describe 'find_winner' do
    it 'should say straight flush wins over high card' do
      game = Game.new %w[Black: 2H 3D 5S 9C KD  White: 2H 3H 4H 5H 6H]
      expect(game.find_winner).to eq :white
    end

    it 'should say three of a kind wins over 2 pair' do
      game = Game.new %w[Black: 2h 2d 2c 3c 5d  White: 2h 2d 3c 3c 5d]
      expect(game.find_winner).to eq :black
    end

    it 'should say four of a kind wins over a flush' do
      game = Game.new %w[Black: 2H 2D 2S 2C KD  White: 2H AH 4H qH 6H]
      expect(game.find_winner).to eq :black
    end

    it 'should say pair wins over high card' do
      game = Game.new %w[Black: 2H 2D 5S 9C KD  White: 2H 3D 5S 9C KD]
      expect(game.find_winner).to eq :black
    end

    it 'should say straight wins over three of a kind' do
      game = Game.new %w[Black: 2H 2D 2S 9C KD  White: 2H 3S 4D 5H 6H]
      expect(game.find_winner).to eq :white
    end
  end

  describe 'tiebreaker_winner' do
    describe 'case: high card' do
      it 'breaks high card ties by the highest card' do
        game = Game.new %w[Black: 2H 3D 5S 9C KD  White: 2C 3H 4S 8C AH]
        expect(game.tiebreaker_winner).to eq :white
      end

      it 'breaks high card ties by the 2nd highest card if higher cards are tied' do
        game = Game.new %w[Black: 2H 3D 5S 9C AD  White: 2C 3H 4S 8C AH]
        expect(game.tiebreaker_winner).to eq :black
      end

      it 'breaks high card ties by the 3rd highest card if higher cards are tied' do
        game = Game.new %w[Black: 2H 3D 5S 9C AD  White: 2C 3H 4S 9C AH]
        expect(game.tiebreaker_winner).to eq :black
      end

      it 'breaks high card ties by the 4th highest card if higher cards are tied' do
        game = Game.new %w[Black: 2H 4D 5S 9C AD  White: 2C 3H 5S 9C AH]
        expect(game.tiebreaker_winner).to eq :black
      end

      it 'breaks high card ties by the 5th highest card if higher cards are tied' do
        game = Game.new %w[Black: 2H 4D 5S 9C AD  White: 3C 4H 5S 9C AH]
        expect(game.tiebreaker_winner).to eq :white
      end

      it 'returns :tie if both hands are the same' do
        game = Game.new %w[Black: 2H 3D 5S 9C AD  White: 2C 3H 5S 9C AH]
        expect(game.tiebreaker_winner).to eq :tie
      end
    end

    describe 'case: pair' do
      it 'breaks the tie by the value of the pair' do
        game = Game.new %w[Black: 2H 3D 2S 9C AD  White: 2C 3H 5S 9C 3H]
        expect(game.tiebreaker_winner).to eq :white
      end

      it 'breaks the tie by the highest single card if the pairs are the same' do
        game = Game.new %w[Black: 3H 4D 3S 9C kD  White: 2C 3H 5S 9C 3H]
        expect(game.tiebreaker_winner).to eq :black
      end

      it 'breaks the tie by the highest unique card if the pairs and others are the same' do
        game = Game.new %w[Black: 3H 2D 3S 9C kD  White: 4C 3H 5S kC 3H]
        expect(game.tiebreaker_winner).to eq :black
      end

      it 'returns :tie if both hands are the same' do
        game = Game.new %w[Black: 4C 3H 5S kC 3H  White: 4C 3H 5S kC 3H]
        expect(game.tiebreaker_winner).to eq :tie
      end
    end

    describe 'case: 2 pair' do
      it 'breaks the tie by the highest pair' do
        game = Game.new %w[Black: 2d 2s th td js White: 4d 4s 8h 8d as]
        expect(game.tiebreaker_winner).to eq :black
      end

      it 'breaks the tie by the next pair if the first is the same' do
        game = Game.new %w[Black: 2d 2s th td aS White: 4d 4s th td js]
        expect(game.tiebreaker_winner).to eq :white
      end

      it 'breaks the tie by the last card if the pairs are the same' do
        game = Game.new %w[Black: 2d 2s th td js White: 2d 2s th td as]
        expect(game.tiebreaker_winner).to eq :white
      end

      it 'returns :tie if both hands are the same' do
        game = Game.new %w[Black: 2d 2s th td js White: 2d 2s th td js]
        expect(game.tiebreaker_winner).to eq :tie
      end
    end

    describe 'case: 3 of a kind' do
      it 'breaks the tie by the trio' do
        game = Game.new %w[Black: 2d 2s 2h td js White: 4d 4s 4h 8d 3s]
        expect(game.tiebreaker_winner).to eq :white
      end

      it 'breaks by the next highest if the trio is the same' do
        game = Game.new %w[Black: 2d 2s 2h 7d 8s White: 2d 2s 2h 5d ts]
        expect(game.tiebreaker_winner).to eq :white
      end

      it 'breaks by the next highest if the trio is the same' do
        game = Game.new %w[Black: 2d 2s 2h 7d ts White: 2d 2s 2h 5d ts]
        expect(game.tiebreaker_winner).to eq :black
      end

      it 'returns :tie if both hands are the same' do
        game = Game.new %w[Black: 2d 2s 2h td js White: 2d 2s 2h td js]
        expect(game.tiebreaker_winner).to eq :tie
      end
    end

    describe 'case: full house' do
      it 'breaks the tie by the trio' do
        game = Game.new %w[Black: 2d 2s 2h td ts White: 4d 4s 4h 3d 3s]
        expect(game.tiebreaker_winner).to eq :white
      end

      it 'breaks by the pair if the trio is the same' do
        game = Game.new %w[Black: 2d 2s 2h 7d 7s White: 2d 2s 2h td ts]
        expect(game.tiebreaker_winner).to eq :white
      end

      it 'returns :tie if both hands are the same' do
        game = Game.new %w[Black: 2d 2s 2h td ts White: 2d 2s 2h td ts]
        expect(game.tiebreaker_winner).to eq :tie
      end
    end

    describe 'case: 4 of a kind' do
      it 'breaks the tie by the quad' do
        game = Game.new %w[Black: 2d 2s 2h 2d ts White: 4d 4s 4h 4d 3s]
        expect(game.tiebreaker_winner).to eq :white
      end

      it 'breaks by the remaining card if the quad is the same' do
        game = Game.new %w[Black: 2d 2s 2h 2d 7s White: 2d 2s 2h 2d ts]
        expect(game.tiebreaker_winner).to eq :white
      end

      it 'returns :tie if both hands are the same' do
        game = Game.new %w[Black: 2d 2s 2h 2d ts White: 2d 2s 2h 2d ts]
        expect(game.tiebreaker_winner).to eq :tie
      end
    end
  end

  describe 'to_str' do
    it 'return the winner with their rank and highest card if they won with a high card' do
      game = Game.new %w[Black: 2H 3D 5S 9C KD  White: 2C 3H 4S 8C AH]
      expect(game.to_str).to eq "White wins. - with high card: Ace"
    end

    it 'return the winner with their rank and highest card if they won with a full house' do
      game = Game.new %w[Black: 2H 4S 4C 2D 4H  White: 2S 8S AS QS 3S]
      expect(game.to_str).to eq "Black wins. - with full house: 4 over 2"
    end

    it 'return Tie. if the game tied' do
      game = Game.new %w[Black: 2H 3D 5S 9C KD  White: 2D 3H 5C 9S KH]
      expect(game.to_str).to eq "Tie."
    end
  end
end
