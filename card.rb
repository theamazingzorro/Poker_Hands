class Card
  attr_accessor :suit
  attr_accessor :val

  def initialize(str)
    if /^.H$/i =~ str
      @suit= :hearts
    elsif /^.D$/i =~ str
      @suit= :diamonds
    elsif /^.S$/i =~ str
      @suit= :spades
    elsif /^.C$/i =~ str
      @suit= :clubs
    end

    if /^\d.$/ =~ str
      @val= str[0,1].to_i
      @value_string = "#{val}"
    elsif /^A.$/i =~ str
      @val= 14
      @value_string = "Ace"
    elsif /^T.$/i =~ str
      @val= 10
      @value_string = "10"
    elsif /^J.$/i =~ str
      @val= 11
      @value_string = "Jack"
    elsif /^Q.$/i =~ str
      @val= 12
      @value_string = "Queen"
    elsif /^K.$/i =~ str
      @val= 13
      @value_string = "King"
    end
  end

  def ==(other)
    self.suit == other.suit && self.val == other.val
  end

  def to_str
    @value_string
  end
end