# frozen_string_literal: true

require_relative '../lib/tic_tac_toe'
require_relative '../lib/board'
require_relative '../lib/board_printer'

describe TicTacToe do
  let(:board) do
    instance_double(
      Board,
      make_move: nil,
      get_player: nil,
      possible_moves: [],
      possible_move?: true
    )
  end
  let(:board_printer) { instance_double(BoardPrinter, print: nil) }

  subject { TicTacToe.new(board, board_printer) }

  describe '#game_loop' do
    context 'when the game is neither won, nor a draw and then won' do

      before do
        allow(subject).to receive(:win?).and_return(false, true)
        allow(subject).to receive(:draw?).and_return(false)
        allow(subject).to receive(:puts)
        allow(subject).to receive(:read_user_input)
      end

      it 'terminates and returns nil' do
        expect(subject.game_loop).to be nil
      end

      # outgoing command
      it 'prints the board' do
        expect(board_printer).to receive(:print).once
        subject.game_loop
      end

      # outgoing command
      it 'makes a move' do
        expect(board).to receive(:make_move)
        subject.game_loop
      end
    end

    context 'when the game is a draw' do
      it 'terminates and returns nil' do
        allow(subject).to receive(:win?).and_return(false)
        allow(subject).to receive(:draw?).and_return(true)
        expect(subject.game_loop).to be nil
      end
    end
  end

  describe '#draw?' do
    it 'returns true, if there are no more moves left on the board' do
      allow(subject).to receive(:puts)
      allow(board).to receive(:possible_moves).and_return([])
      expect(subject.draw?).to be true
    end

    it 'returns false, if there are still moves left' do
      allow(board).to receive(:possible_moves).and_return([1])
      expect(subject.draw?).to be false
    end
  end

  describe '#win?' do
    context 'when there is a winner' do
      before do
        allow(board).to receive(:check_for_winner).and_return('X')
        allow(subject).to receive(:puts)
      end

      it 'returns the symbol of the winner' do
        expect(subject.win?).to be 'X'
      end

      it 'outputs a message about the winner' do
        expect(subject).to receive(:puts).twice
        expect(subject)
          .to receive(:puts)
          .with('And the winner is player X. Congratulations!')
        subject.win?
      end

      it 'prints the board' do
        expect(board_printer).to receive(:print)
        subject.win?
      end
    end

    it 'returns nil, if there is no winner' do
      allow(subject).to receive(:puts)
      allow(board).to receive(:check_for_winner).and_return(nil)
      expect(subject.win?).to be nil
    end
  end

  describe '#read_user_input' do
    before do
      allow(board).to receive(:possible_moves)
      allow(subject).to receive(:gets).and_return("1\n")
      allow(subject).to receive(:puts)
      allow(subject).to receive(:p)
      allow(subject).to receive(:exit)
      allow(board).to receive(:possible_move?).and_return(true)
    end

    it 'prints the possible moves of the board' do
      expect(subject).to receive(:p).with(board.possible_moves)
      subject.read_user_input
    end

    it 'exits the script if user inputs "Q"' do
      allow(subject).to receive(:gets).and_return("Q\n", "1\n")
      expect(subject).to receive(:exit)
      subject.read_user_input
    end

    it 'returns the user input, if it is a valid move' do
      expect(subject.read_user_input).to eq '1'
    end

    it 'requests user input again, if it is no valid move or "Q"' do
      allow(board).to receive(:possible_move?).and_return(false, true)
      expect(subject).to receive(:gets).twice
      subject.read_user_input
    end
  end
end
