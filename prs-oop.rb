# Paper rock scissors is a game involving two players.  Each player chooses either a paper, rock or a pair of scissors. 
# The hands are compared. Paper beats Rock, Rock beats scissors and scissors beats paper
class Game
  CHOICES = {'p' => 'Paper', 'r' => 'Rock', 's' => 'Scissors'}

  attr_reader :player, :computer
  
  def initialize
    puts "Please type in your name"
    @player = Human.new(gets.chomp)
    @computer = Computer.new("C3PO")
  end

  def play
    player.pick_hand
    computer.pick_hand
    puts player
    puts computer
    compare_hands
  end

  def compare_hands
    if player.hand == computer.hand
      puts "Its a tie"
    elsif player.hand > computer.hand
      player.hand.display_winning_message
      puts "#{player.name} won!"
    else
      computer.hand.display_winning_message
      puts "#{computer.name} won!"
    end
  end
end


class Hand
  include Comparable

  attr_reader :value

  def initialize (v)
    @value = v
  end

  def <=> (another_hand)
    if value == another_hand.value
      0
    elsif (value == 'r' && another_hand.value == 's') ||
        (value == 'p' && another_hand.value == 'r' )||
        (value == 's' && another_hand.value == 'p')
      1
    else
      -1
    end
  end

  def display_winning_message
    case @value
    when 'p'
      puts 'Paper wraps up rock'
    when 'r'
      puts 'Rock smashes scissors'
    when 's'
      puts 'Scissors cut paper'
    end
  end
end


class Player

  attr_accessor :hand
  attr_reader :name

  def initialize (name)
    @name = name
  end

  def to_s
    "#{name} used #{Game::CHOICES[hand.value]}"
  end
end

class Human < Player
  def pick_hand
    begin
      puts "Pick your choice of (R)ock, (P)aper or (S)cissors"
      hand_choice = gets.chomp.downcase
    end until Game::CHOICES.keys.include?(hand_choice)

    self.hand = Hand.new (hand_choice)
  end
end

class Computer < Player
  def pick_hand
    self.hand = Hand.new(Game::CHOICES.keys.sample)
  end
end

puts "-------------------------------"
puts "Welcome to Paper, Rock Scissors"
puts "-------------------------------"
puts
game = Game.new
begin
  game.play
  puts
  puts "Do you want to play again? (y/n)"
  play_again = gets.chomp.downcase
  puts
end until play_again == 'n'
puts "Goodbye"