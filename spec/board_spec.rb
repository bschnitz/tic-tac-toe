# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe 'get_player' do
    it 'returns X if player is even' do
      expect(subject.get_player(24)).to eq 'X'
    end

    it 'returns O if player is odd' do
      expect(subject.get_player(9)).to eq 'O'
    end
  end

  describe '#check_for_winner' do
    it 'returns nil, if no move was made yet' do
      expect(subject.check_for_winner).to eq nil
    end

    it 'returns nil after the first move of X' do
      subject.make_move(1, 'X')
      expect(subject.check_for_winner).to eq nil
    end

    it 'returns O if O has made a diagonal winning move' do
      subject.make_move(1, 'X')
      subject.make_move(4, 'O')
      subject.make_move(7, 'X')
      subject.make_move(8, 'O')
      subject.make_move(3, 'X')
      subject.make_move(0, 'O')
      expect(subject.check_for_winner).to eq 'O'
    end

    it 'returns X if X has made a winning move in the first row' do
      subject.make_move(0, 'X')
      subject.make_move(1, 'X')
      subject.make_move(2, 'X')
      expect(subject.check_for_winner).to eq 'X'
    end

    it 'returns O if O has made a winning move in the last column' do
      subject.make_move(2, 'O')
      subject.make_move(5, 'O')
      subject.make_move(8, 'O')
      expect(subject.check_for_winner).to eq 'O'
    end

    it 'returns nil, after all moves are done without winning move' do
      subject.make_move(0, 'O')
      subject.make_move(1, 'X')
      subject.make_move(2, 'O')
      subject.make_move(4, 'X')
      subject.make_move(3, 'O')
      subject.make_move(5, 'X')
      subject.make_move(6, 'O')
      subject.make_move(7, 'X')
      subject.make_move(8, 'O')
      expect(subject.check_for_winner).to eq nil
    end

    describe '#make_move' do
      context 'when making a move at position 4' do
        let(:position) { 4 }

        it 'sets the last position to [1, 1]' do
          expect { subject.make_move(position, 'X') }
            .to change { subject.last_move_at }
            .to([1, 1])
        end

        it 'sets the rows array at [1, 1] to the symbol of the player' do
          expect { subject.make_move(position, 'X') }
            .to change { subject.rows[1][1] }
            .to('X')
        end
      end

      context 'when making a move at position 5' do
        let(:position) { 5 }

        it 'sets the last position to [1, 2]' do
          expect { subject.make_move(position, 'X') }
            .to change { subject.last_move_at }
            .to([1, 2])
        end

        it 'sets the rows array at [1, 2] to the symbol of the player' do
          expect { subject.make_move(position, 'O') }
            .to change { subject.rows[1][2] }
            .to('O')
        end
      end

      context 'when making a move at position 6' do
        let(:position) { 6 }

        it 'sets the last position to [0, 2]' do
          expect { subject.make_move(position, 'X') }
            .to change { subject.last_move_at }
            .to([2, 0])
        end

        it 'sets the rows array at [0, 2] to the symbol of the player' do
          expect { subject.make_move(position, 'O') }
            .to change { subject.rows[2][0] }
            .to('O')
        end
      end

      describe '#possible_moves' do
        it 'returns all fields (0..8) at the beginning' do
          expect(subject.possible_moves).to eq((0..8).to_a)
        end

        it 'returns [0, 1, 2, 3, 5, 6, 7, 8] after making a move to 4' do
          subject.make_move(4, 'X')
          expect(subject.possible_moves).to eq([0, 1, 2, 3, 5, 6, 7, 8])
        end

        it 'returns [0, 2, 3, 5] after making moves to 4, 1, 8, 6, 7' do
          subject.make_move(4, 'X')
          subject.make_move(1, 'X')
          subject.make_move(8, 'X')
          subject.make_move(6, 'X')
          subject.make_move(7, 'X')
          expect(subject.possible_moves).to eq([0, 2, 3, 5])
        end
      end

      describe 'possible_move?' do
        it 'returns false, if move is not a number in (0..8)' do
          expect(subject.possible_move?('9')).to eq false
          expect(subject.possible_move?('X')).to eq false
        end

        it 'returns true for any number in 1..8 at the beginning of the game' do
          (0..8).each { |n| expect(subject.possible_move?(n.to_s)).to eq true }
        end

        context 'after moves to 0, 7, 8, 3' do
          before do
            subject.make_move(0, 'X')
            subject.make_move(7, 'X')
            subject.make_move(8, 'X')
            subject.make_move(3, 'X')
          end

          it 'returns true for a move to 2 or 6' do
            expect(subject.possible_move?('2')).to eq true
            expect(subject.possible_move?('6')).to eq true
          end

          it 'returns false for a move to 0 or 8' do
            expect(subject.possible_move?('0')).to eq false
            expect(subject.possible_move?('8')).to eq false
          end
        end
      end
    end
  end
end
