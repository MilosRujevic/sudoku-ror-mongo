class Game
  include Mongoid::Document
  include Mongoid::Timestamps

  field :level, type: Integer
  field :sudoku

  def generate_sudoku
    #  Matrix.build(3, 3) {|row, col| rand(2) } 
    res = []
    res[0] = rand(0 .. 9)
    res[1] = rand(0 .. 9)
    res[2] = rand(0 .. 9)
    res[3] = rand(0 .. 9)
    res[4] = rand(0 .. 9)
    res[5] = rand(0 .. 9)
    res[6] = rand(0 .. 9)
    res[7] = rand(0 .. 9)
    res[8] = rand(0 .. 9)
    self.sudoku = res
    self.save
    res
  end

  def self.matrix
    mat = Matrix[[1,2], [3,4]]
  end

  def matrix2
    Matrix[[1,2], [3,4]]
  end

  def generate_sudoku_matrix
    m1 = Matrix[[1,2], [3,4]]
    self.sudoku = m1
    self.salve
    m1
  end


  belongs_to :user

end