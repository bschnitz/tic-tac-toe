# frozen_string_literal: true

# Prints the TicTacToe Board inside the terminal
class BoardPrinter
  def initialize(board)
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
