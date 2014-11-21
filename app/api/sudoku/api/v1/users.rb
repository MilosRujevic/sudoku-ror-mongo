class Sudoku::API::V1::Users < Grape::API

  resource :users do
    get do
      User.all
    end
  end
end