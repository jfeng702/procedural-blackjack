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

puts "You have #{player_cards[0]} and #{player_cards[1]} for a value of #{player_total}"
puts "Dealer has #{dealer_cards[0]} and #{dealer_cards[1]} for a value of #{dealer_total}"

blackjack("Player", player_cards)
blackjack("Dealer", dealer_cards)



# Player Turn
choice = 0
while choice != '2'
  puts "Do you want to 1)Hit or 2)Stay? "
  choice = gets.chomp
  if choice == "1"
    new_card = deck.pop
    player_cards << new_card
    player_total = evaluate(player_cards)
    puts "You are dealt #{new_card} and now have a value of #{player_total}"
    if evaluate(player_cards) > 21
      puts "Sorry you busted."
      exit
    elsif evaluate(player_cards) == 21
      puts "You hit Blackjack!"
      exit
    end
  elsif choice == "2"
    puts "You chose to stay."
  else
    puts "You need to choose Hit or Stay."
  end
end

# Dealer Turn
  while evaluate(dealer_cards) < 17 
    puts "Dealer hits."
    new_card = deck.pop
    dealer_cards << new_card
    dealer_total = evaluate(dealer_cards)
    puts "Dealer was dealt #{new_card} and has a value of #{dealer_total} "
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
    puts "Dealer stays"
    puts "You win"
  elsif evaluate(dealer_cards) > evaluate(player_cards)
    puts "Dealer stays"
    puts "You lose"
  else
    puts "tie"
  end