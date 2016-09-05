require 'pry'

# construct a deck of 52 cards, 13 from each suit (array?)
# shuffle
# Deal 1 to player
# Deal 1 to dealer
# Deal 1 to player
# Deal 1 to dealer
# Check if any blackjack (combination of 10 value card + A)
# Player Turn
# Player can Stay or Hit
# Can keep on Hitting until they bust, or hit Blackjack, or stay
# Computer Turn
# Hit until has at least 17
# Evaluate cards

# hand [['A', 'D'], ['Q', 'D'], ['10', 'D']]

def initialize_deck
  ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"].product(['S', 'H', 'C', 'D'])
end

def shuffle(deck)
  deck.shuffle!
end

def deal_card(deck)
  deck.pop
end

def blackjack(player, hand)
  if hand[0][0] == 'A'&& ['10', 'J', 'Q', 'K'].include?(hand[1][0])
    puts "#{player} hits Blackjack!"
    exit
  elsif hand[1][0] == 'A' && ['10', 'J', 'Q', 'K'].include?(hand[0][0])
    puts "#{player} hits Blackjack!" 
    exit
  end
end

=begin
def evaluate(hand)
  value = 0
  hand.each do |card|
    if ['K', 'Q', 'J'].include?(card[0][0])
      value += 10
    elsif card[0][0] == 'A'
      value += 11
    else
      value += card[0][0].to_i
    end
  end
  value
end
=end

# The each function is iterating over every element in the array when it should be iterating over only the first element in every array. (The value of the card and not the suit).

def evaluate(hand)  
  value = 0
  numerical_value = hand.map { |card| card[0]}     
  numerical_value.each do |x|      
    if ['K', 'Q', 'J'].include?(x)
      value += 10
    elsif x == 'A'
      value += 11
    else
      value += x.to_i
    end
  end
  
  hand.select {|x| x[0] == 'A'}.count.times do 
    if value > 21
      value -= 10
    end
  end
  value
end

def dealer_turn
  while dealer_total < 17
    dealer_cards << deck.pop
    p dealer_cards
    if dealer_total > 21
      puts "Dealer Busted. You win."
      exit

    elsif dealer_total == 21
      puts "Dealer hit blackjack! You lose."
      exit
    end
  end
end

=begin
def player_turn
 # while evaluate(player_cards) < 21
    puts "Do you want to 1)Hit or 2)Stay? "
    choice = gets.chomp
    if choice == "1"
      deal_card(player_cards)
      p player_cards
      if evaluate(player_cards) > 21
        puts "Sorry you busted."
      end
    end
  #end
end
=end

player_cards = []
dealer_cards = []

deck = initialize_deck
shuffle(deck)

player_cards << deck.pop
dealer_cards << deck.pop
player_cards << deck.pop
dealer_cards << deck.pop

dealer_total = evaluate(dealer_cards)
player_total = evaluate(player_cards)

p player_cards
p dealer_cards

blackjack("Player", player_cards)
blackjack("Dealer", dealer_cards)

# Player Turn
choice = 0
while choice != '2'
  puts "The value of your hand is #{evaluate(player_cards)}"
  puts "The value of dealer's hand is #{evaluate(dealer_cards)}"
  puts "Do you want to 1)Hit or 2)Stay? "
  choice = gets.chomp
  if choice == "1"
    player_cards << deck.pop
    p player_cards
    if evaluate(player_cards) > 21
      puts "Sorry you busted."
      exit
    elsif evaluate(player_cards) == 21
      puts "You hit Blackjack!"
      exit
    end
  elsif choice == "2"
    puts "You chose to stay."
  end


end

# Dealer Turn
  while evaluate(dealer_cards) < 17
    puts "Dealer has #{evaluate(dealer_cards)}."
    puts "Dealer hits."
    dealer_cards << deck.pop
    p dealer_cards
    if evaluate(dealer_cards) > 21
      puts "Dealer Busted. You win."
      exit

    elsif evaluate(dealer_cards) == 21
      puts "Dealer hit blackjack! You lose."
      exit
    end
  end

# Showdown
  if evaluate(player_cards) > evaluate(dealer_cards)
    puts "you win"
  elsif evaluate(dealer_cards) > evaluate(player_cards)
    puts "Dealer has #{evaluate(dealer_cards)}."
    puts "you lose"
  else
    puts "tie"
  end