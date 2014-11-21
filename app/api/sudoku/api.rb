module Sudoku
  class API < Grape::API
    mount Sudoku::API::V1
    add_swagger_documentation mount_path: '/api-docs', base_path: '/api', api_version: 'v1'

  end
end