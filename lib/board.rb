# frozen_string_literal: true

# Logic for the Tic Tac Toe Board
class Board
  attr_reader :rows, :symbols, :last_move_at

  def initialize
    @rows = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ]

    @last_move_at = nil
    @symbols = %w[X O]
  end

  def get_player(number)
    @symbols[number % @symbols.length]
  end

  # returns the symbol of the winner, if a winner exists
  def check_for_winner
    return unless @last_move_at

    row = @last_move_at[0]
    col = @last_move_at[1]

    # this is unnecessarily complicate, one could just check the complete board
    positions = [] # store the positions to be checked
    positions.push([[0, 0], [1, 1], [2, 2]]) if row == col     # diagonal
    positions.push([[0, 2], [1, 1], [2, 0]]) if row + col == 2 # diagonal
    positions.push(([row] * 3).zip([0, 1, 2]))                 # row
    positions.push([0, 1, 2].zip([col] * 3))                   # column

    check_positions_for_winner(positions)
  end

  # number is the position count in (0..8), value must be in ['X', 'O']
  def make_move(number, value)
    @last_move_at = get_position_at(number)
    self[*get_position_at(number)] = value
  end

  # returns all moves which are yet possible (d.i. not yet made)
  def possible_moves
    @rows.reduce([]) do |moves, row|
      moves.concat(row.reject { |value| @symbols.include?(value) })
    end
  end

  def possible_move?(character)
    return false unless character.to_i.to_s == character

    possible_moves.include?(character.to_i)
  end

  private

  # number is the position count in (0..8), returns [row, col]
  def get_position_at(number)
    [(number - number % 3) / 3, number % 3]
  end

  def [](row, col)
    @rows[row][col]
  end

  def []=(row, col, value)
    @rows[row][col] = value
  end

  # returns the symbol of the winner, if a winner exists
  def check_positions_for_winner(position_groups)
    position_groups.each do |group|
      return self[*(group[0])] if
        group.map { |pos| self[*pos] }.uniq.length == 1
    end
    nil
  end
end
