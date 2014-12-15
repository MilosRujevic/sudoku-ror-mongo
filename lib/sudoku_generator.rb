class SudokuGenerator

  def initialize
    puzzle = [0] * 81
    a = (1..9).sort_by{rand}
    b = (1..9).sort_by{rand}
    c = (1..9).sort_by{rand}

    puzzle[0..2] = a[0..2]
    puzzle[9..11] = a[3..5]
    puzzle[18..20] = a[6..8]

    puzzle[30..32] = b[0..2]
    puzzle[39..41] = b[3..5]
    puzzle[48..50] = b[6..8]

    puzzle[60..62] = b[0..2]
    puzzle[69..71] = b[3..5]
    puzzle[78..80] = b[6..8]
    puzzle = puzzle.join

    @@p = puzzle.split(//)
  end

  def generate_sudoku(level)
    solver
    res = {}
    res[:solution] = sudokuArray
    res[:level] = level

    case level
      when 3
        res[:sudoku] = level1
      when 2
        res[:sudoku] = level2
      when 1
        res[:sudoku] = level3
      else

    end
    res
  end

  def solver
    81.times do |j|
      next if @@p[j].to_i!=0

      candidatesArray = getCandidates(j)

      candidatesArray.each  do |v|
        @@p[j]=v.to_s
        foundAll = solver
        if(foundAll == true)
          return true
        end
      end
      @@p[j]=0
      return false
    end

    return true
  end

  def getCandidates(j)

    array = [1,2,3,4,5,6,7,8,9]

    row = j/9 *9
    col = j%9

    9.times do |k|
      m = @@p[row+k].to_i
      if(m)
        array.delete(m)
      end
    end

    9.times do |k|
      m = @@p[k*9 + col].to_i
      if(m)
        array.delete(m)
      end
    end

    start_row = j/27 * 3
    start_col = j%9/3 * 3
    3.times do |t|
      3.times do |l|
        m =  @@p[(start_row + t)*9 + start_col + l].to_i
        if(m)
          array.delete(m)
        end
      end
    end
    return array

  end

  def printResult


    1.upto(81) do |x|
      print " #{@@p[x-1]} "
      if x%3==0 and x%9 !=0
        print "|"
      end
      if x%9==0 and x%81 !=0

      end
      if x%81==0
        puts "|"
      end
    end


  end

  def sudokuArray
    res = []
    0.upto(80) do |x|
      res << @@p[x]
    end
    res
  end


  def level1
    l1 = sudokuArray
    64.times{l1[rand(81)] = 0}
    l1
  end

  def level2
    l2 = sudokuArray
    47.times{l2[rand(81)] = 0}
    l2
  end

  def level3
    l3 = sudokuArray
    20.times{l3[rand(81)] = 0}
    l3
  end



end

