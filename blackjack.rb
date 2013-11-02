# Interactive command line blackjack game


def calculate_total(cards) 
  # [['H', '3'], ['S', 'Q'], ... ]
  arr = cards.map{|e| e[1] }

  total = 0
  arr.each do |value|
    if value == "A"
      total += 11
    elsif value.to_i == 0 # J, Q, K
      total += 10
    else
      total += value.to_i
    end
  end

  #correct for Aces
  arr.select{|e| e == "A"}.count.times do
    total -= 10 if total > 21
  end

  total
end

puts "Welcome to Blackjack!"

suits = ['H', 'D', 'S', 'C']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

deck = suits.product(cards)
deck.shuffle!

# Deal Cards

mycards = []
dealercards = []

mycards << deck.pop
dealercards << deck.pop
mycards << deck.pop
dealercards << deck.pop

dealertotal = calculate_total(dealercards)
mytotal = calculate_total(mycards)

# Show Cards

puts "Dealer has: #{dealercards[0]} and #{dealercards[1]}, for a total of #{dealertotal}"
puts "You have: #{mycards[0]} and #{mycards[1]}, for a total of: #{mytotal}"
puts ""
puts "What would you like to do? 1) hit 2) stay"
hit_or_stay = gets.chomp

while true
  if hit_or_stay == 1 || hit_or_stay == 'hit' 
    mycards << deck.pop
    mytotal = calculate_total(mycards)

    puts "Dealer has: #{dealercards[0]} and #{dealercards[1]}, for a total of #{dealertotal}"
    puts "You have: "
    mycards.each do |e|
      puts "#{e}"
    end
    puts "Your total: #{mytotal}"

    if mytotal > 21
      puts "Busted!"
      break
    elsif mytotal == 21
      puts "You won!"
      break
    else
      hit_or_stay = gets.chomp
    end
  elsif hit_or_stay == 'stay' || hit_or_stay == 2
    while dealertotal < 17 do
      dealercards << deck.pop
      dealertotal = calculate_total(mycards)
    end
  
    puts "Dealer has: "
    dealercards.each do |e|
      puts "#{e}"
    end
    puts "Dealer's total: #{dealertotal}"
    puts "You have: #{mycards[0]} and #{mycards[1]}, for a total of: #{mytotal}"  
    if dealertotal < mytotal
      puts "You won!"
    else
      puts "Busted!"
    end
    gameon = false
    break
  else
    puts "Enter correct answer."
    puts "What would you like to do? 1) hit 2) stay"
    hit_or_stay = gets.chomp
  end
end
  