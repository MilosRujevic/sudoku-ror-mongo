class Sudoku::API::V1 < Grape::API
  version 'v1', using: :path, vendor: 'Sudoku'
  format :json

  mount Users


end