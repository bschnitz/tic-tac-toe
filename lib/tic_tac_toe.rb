# frozen_string_literal: true

require_relative './board'
require_relative './board_printer'

# Tic Tac Toe game loop
class TicTacToe
  def initialize
    @board = Board.new
    @board_printer = BoardPrinter.new(@board)
  end

  def game_loop
    player_number = 0
    until check_for_winner
      puts
      @board_printer.print
      puts "\nPlayer #{@board.get_player(player_number)} make your move!"
      @board.make_move(read_user_input.to_i, @board.get_player(player_number))
      player_number = (player_number + 1) % 2
    end
  end

  private

  def check_for_winner
    winner = @board.check_for_winner
    if winner
      puts
      @board_printer.print
      puts
      puts "And the winner is player #{winner}. Congratulations!"
    end
    winner
  end

  def read_user_input
    loop do
      puts 'Please input one of the following number to make a move, ' \
        'or press "Q" to quit.'
      p @board.possible_moves

      input = gets.chomp

      exit if input.upcase == 'Q'

      return input if @board.possible_move?(input)
    end
  end
end
