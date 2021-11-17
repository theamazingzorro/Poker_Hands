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
      expect(game.winner).to eq :white
    end
  end

end
