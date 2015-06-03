require './db/setup'
require './lib/all'
require 'pry'

class TicTacToe 
  attr_reader :current_player, :player_o, :player_x

  def initialize player_x, player_o
    @player_x = player_x
    @player_o = player_o
    @current_symbol = :x
    # @players = [Player.new(:x), Player.new(:o)]
    @board   = Array.new 9
    @current_player = @player_x
  end

  def over?
    winner || board_full?
  end

  def board_full?
    !@board.include?(nil)
  end

  def value_in position
    @board[position.to_i - 1]
  end

  def record_move position
    @board[position.to_i - 1] = @current_symbol
  end

  def lines
    [
      [1,2,3],
      [4,5,6],
      [7,8,9],
      [1,4,7],
      [2,5,8],
      [3,6,9],
      [1,5,9],
      [3,5,7]
    ]
  end

  def winner
    lines.each do |line|
      values = line.map { |position| value_in position }
      if values.all? { |v| v == :x }
        return :x
      elsif values.all? { |v| v == :o }
        return :o
      end
    end
    return nil # no winner yet
  end

  def display_board
    "#{display_row(1,2,3)}\n#{display_row(4,5,6)}\n#{display_row(7,8,9)}"
  end

  def display_row a,b,c
    [a,b,c].map { |position| value_in(position) || position }.join ""
  end

  def take_move position
    record_move position
    toggle_players
  end

  def toggle_players
    if @current_player == @player_x
      @current_symbol = :o
      @current_player = @player_o
    else
      @current_symbol = :x
      @current_player = @player_x
    end
  end
end

p1 = User.make_user
p2 = User.make_user
ttt = TicTacToe.new p1, p2
puts "#{p1.name} has #{Stat.wins(p1)} wins and #{Stat.losses(p1)} losses."
puts "#{p2.name} has #{Stat.wins(p2)} wins and #{Stat.losses(p2)} losses."
until ttt.over?
  puts ttt.display_board
  print "#{ttt.current_player.name} - where would you like to play? "

  move = gets.chomp
  ttt.take_move move
end

if ttt.winner
  if ttt.winner == :x
    puts "#{p1.name} wins!"
    Stat.create! player_x_id: ttt.player_x.id, player_o_id: ttt.player_o.id, player_x_won: true, player_o_won: false, draw: false
  elsif ttt.winner == :o 
    puts "#{p2.name} wins!"
    Stat.create! player_x_id: ttt.player_x.id, player_o_id: ttt.player_o.id, player_x_won: false, player_o_won: true, draw: false
  end
else
  puts "It's a draw"
  Stat.create! player_x_id: ttt.player_x.id, player_o_id: ttt.player_o.id, player_x_won: false, player_o_won: false, draw: true
end