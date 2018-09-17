# class to represent card object in game of set
class Card
    # constructor
    def initialize(number, color, shape, texture)
        @number = number
        @color = color
        @shape = shape
        @texture = texture
    end

    attr_accessor :number
    attr_accessor :color
    attr_accessor :shape
    attr_accessor :texture

    # returns str rep of card
    def to_s
        "#{@number}, #{@color}, #{@shape}, #{@texture}"
    end

end
