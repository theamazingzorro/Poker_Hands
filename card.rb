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
    elsif /^A.$/i =~ str
      @val= 1
    elsif /^T.$/i =~ str
      @val= 10
    elsif /^J.$/i =~ str
      @val= 11
    elsif /^Q.$/i =~ str
      @val= 12
    elsif /^K.$/i =~ str
      @val= 13
    end
  end

end