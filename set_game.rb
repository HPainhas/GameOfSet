require_relative 'card'
require 'timeout'

@deck = Array.new
@cards_in_play = Array.new
@player_names = Array.new
@player_points = Array.new
@numbers = 1..3
@colors = ["red", "green", "blue"]
@shapes = ["triangle", "square", "circle"]
@textures = ["open", "solid", "striped"]

# generate deck of 81 cards using every combo of the attributes
def generate_deck
    (1..3).to_a.product(@colors, @shapes, @textures).each{|arr| @deck.push(Card.new(arr[0], arr[1], arr[2], arr[3]))}
    @deck.shuffle!
end

# deals 3 cards if available
def deal_cards
    if @deck.length != 0
        puts "Dealt 3 more cards"
        for i in 0...3
            r = rand(0...@deck.length)
            @cards_in_play.append(@deck[r])
            @deck.delete_at(r)
        end
    else
        puts "There are no more cards in the deck!"
    end
end

def update_deck(is_set, play_num, set)
    if is_set
        player_score_index = @player_names.index(play_num)

        puts "\nYou found a set! Updating deck..."

        if player_score_index != nil
            @player_points[player_score_index] += 1
        else
            @player_names << play_num
            @player_points << 1
        end

        # remove set from cards in play
        for card in set
            @cards_in_play.delete(card)
        end

        deal_cards # deal 3 more cards
    else
        puts "\nThat is not a set!"
    end
end

# prints a deck of cards
def print_cards
    for card in @cards_in_play
        puts (@cards_in_play.index(card) + 1).to_s + ". " + card.to_s + "\n"
    end
end

# gets set from user
def get_set(timeout)
    set = nil
    puts "\n"
    begin
        if timeout != 0
            puts "Find a set in #{timeout} secs!"
        end

        # get set from user in timeout seconds
        Timeout.timeout timeout do
            handle_user_choice 
            puts "Enter your three cards one by one:"
            c1 = gets.chomp.to_i - 1
            c2 = gets.chomp.to_i - 1
            c3 = gets.chomp.to_i - 1
            set = [@cards_in_play[c1], @cards_in_play[c2], @cards_in_play[c3]]
        end
    rescue Timeout::Error
        puts "You ran out of time!"
    end

    set # return set
end


# verify if user's cards form a set or not
def verify_set?(set)
    is_set = false # keep track of valid set

    # get arrays of the cards' attributes
    colors = [set[0].color, set[1].color, set[2].color]
    numbers = [set[0].number, set[1].number, set[2].number]
    shapes = [set[0].shape, set[1].shape, set[2].shape]
    textures = [set[0].texture, set[1].texture, set[2].texture]

    # or any attribute, if the attribute is the same or different
    # across the cards then the cards are a set.
    # this checks that no attribute is the same for two cards
    # and different for another, because that is the only case
    # where the cards are not a set.
    if colors.uniq.length != 2 && numbers.uniq.length != 2 && shapes.uniq.length != 2 && textures.uniq.length != 2
        is_set = true
    end

    # make sure no cards are duplicates
    if set.uniq.length != 3
        is_set = false
    end

    is_set # return value
end

# gives user a list of options while playing set and prompts for choice
def handle_user_choice
    ans = nil # track user input
    while true
        puts "\nChoose one of the following options."
        puts "1. Enter set."
        puts "2. Redeal cards (if no sets)."
        ans = gets.chomp.to_i

        if ans == 1
            break
        elsif ans == 2
            redeal # redeal cards
            print_cards
        else
            puts "Invalid input."
        end
    end

    ans # return user input
end

# redeals the inital 12 cards in case there are no sets in play
def redeal
    # take all current cards in play and add to deck
    @deck.concat(@cards_in_play)
    @cards_in_play = Array.new

    #shuffle cards    
    @deck.shuffle!

    #deal 12 more new cards
    @cards_in_play.concat(@deck.pop(12))
end

def play_set(timeout)
    @cards_in_play.concat(@deck.pop(12))

    puts "Dealing initial cards..."
    while true
        print_cards # print current cards in play
        set = get_set timeout # get set from user

        # if user did not run out of time, verify set
        if set != nil
            is_set = verify_set? set
            puts("What player number are you?")
            play_num = gets.chomp
            update_deck is_set,play_num,set
        end

        puts "Would you like to play again? (y/n)"
        $stdin.flush
        if gets.chomp == "y"
            next
        else
            # list sets found by each player
            for idx in 0...@player_points.length
                if @player_points[idx] > 0
                    puts "Player #{@player_names[idx]} found #{@player_points[idx]} set(s)."
                end
            end
            break
        end
    end
end

### PROGRAM START

inv_in = true # keep track of valid input
timeout = 0 # timeout for user to find set

while inv_in
    puts "Choose a difficulty:"
    puts "1. Unlimited time"
    puts "2. Timed (Easy)"
    puts "3. Timed (Hard)"

    ans = gets.chomp.to_i
    if ans == 1
        timeout = 0
        inv_in = false
    elsif ans == 2
        timeout = 45
        inv_in = false
    elsif ans == 3
        timeout = 15
        inv_in = false
    else
        puts "Invalid input. \n"
    end
end

# generate the deck and start playing set
generate_deck
play_set timeout
