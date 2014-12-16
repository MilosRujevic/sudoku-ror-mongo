class Game
  include Mongoid::Document
  include Mongoid::Timestamps

  field :player_name
  field :level
  field :puzzle

  before_create :generate_game

  def generate_game
    self.puzzle = SudokuGenerator.new.generate_sudoku(self.level.to_i)
  end


end
