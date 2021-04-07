# frozen_string_literal: true

require_relative 'board'

# Prints the TicTacToe Board inside the terminal
class BoardPrinter
  def initialize(board = Board.new)
    @board = board
  end

  # print a nice Tic Tac Toe board to terminal
  def print
    puts '╭───────────╮'                        # top frame for the board
    puts @board
      .rows
      .map { |row| "│ #{row.join(' │ ')} │\n" } # seperate columns by '|'
      .join("│───┼───┼───│\n")                  # separate rows by ...
    puts '╰───────────╯'                        # bottom frame for the board
  end
end
