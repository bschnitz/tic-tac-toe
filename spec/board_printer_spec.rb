# frozen_string_literal: true

require_relative '../lib/board_printer'

describe BoardPrinter do
  describe '#print' do
    it 'returns a board with no moves initially' do
      allow(subject).to receive(:puts)
      expect(subject)
        .to receive(:puts).with('╭───────────╮').once
      expect(subject)
        .to receive(:puts).with(
          "│ 0 │ 1 │ 2 │\n"\
          "│───┼───┼───│\n"\
          "│ 3 │ 4 │ 5 │\n"\
          "│───┼───┼───│\n"\
          "│ 6 │ 7 │ 8 │\n"\
        ).once
      expect(subject)
        .to receive(:puts).with('╰───────────╯').once
      subject.print
    end
  end
end
