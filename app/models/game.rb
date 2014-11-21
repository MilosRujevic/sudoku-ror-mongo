class Game
  include Mongoid::Document
  include Mongoid::Timestamps

  field :level, type: Integer
  field :sudoku

  def generate_sudoku
    res = []
    res[0] = [1,2,3,4,5,nil,7,8,9]
    res[1] = [1,2,3,4,5,6,7,8,9]
    res[2] = [1,2,3,4,5,6,7,8,9]
    res[3] = [1,2,3,4,5,6,7,8,9]
    res[4] = [1,2,3,4,5,6,7,8,9]
    res[5] = [1,2,3,4,5,6,7,8,9]
    res[6] = [1,2,3,4,5,6,7,8,9]
    res[7] = [1,2,3,4,5,6,7,8,9]
    res[8] = [1,2,3,4,5,6,7,8,9]
    self.sudoku = res
    self.save
    res
  end

  belongs_to :user

end