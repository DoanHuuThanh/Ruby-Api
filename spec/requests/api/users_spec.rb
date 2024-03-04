require 'swagger_helper'

describe 'User Sign In API' do

  path '/users/sign_in' do

    post 'User Sign In' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string }
            },
            required: [ 'email', 'password' ]
          }
        },
        required: [ 'user' ]
      }

      response '201', 'user signed in successfully' do
        schema type: :object,
          properties: {
            status: { type: :object,
                      properties: {
                        code: { type: :integer },
                        message: { type: :string }
                      },
                      required: [ 'code', 'message' ] },
            data: { type: :object,
                    properties: {
                      id: { type: :integer },
                      email: { type: :string }
                    },
                    required: [ 'id', 'email' ] }
          },
          required: [ 'status', 'data' ]

        let(:user) { { email: 'thanh@gmail.com', password: '123456' } }
        run_test!
      end

      response '422', 'invalid request' do
        schema type: :object,
          properties: {
            errors: { type: :object }
          },
          required: [ 'errors' ]

        let(:user) { { email: 'user@example.com' } }
        run_test!
      end
    end

    path '/users/sign_out' do
      delete 'User Logout' do
        tags 'Users'
        security [Bearer: {}]
        produces 'application/json'

        response '200', 'User signed out successfully' do
          schema type: :object,
                 properties: {
                   status: {
                     type: :object,
                     properties: {
                       code: { type: :integer },
                       message: { type: :string }
                     },
                     required: [ 'code', 'message' ]
                   },
                   data: {
                     type: :object, # Nếu có dữ liệu muốn trả về
                     properties: {
                       # Mô tả các trường dữ liệu muốn trả về (nếu có)
                     }
                   }
                 },
                 required: [ 'status' ]
          let(:Authorization) { "Bearer #{jwt_token}" } # Thay jwt_token bằng JWT của người dùng đã xác thực
          run_test!
        end

        response '401', 'User has no active session' do
          schema type: :object,
                 properties: {
                   status: {
                     type: :object,
                     properties: {
                       code: { type: :integer },
                       message: { type: :string }
                     },
                     required: [ 'code', 'message' ]
                   }
                 },
                 required: [ 'status' ]
          let(:Authorization) { "Bearer invalid_token" } # Thay invalid_token bằng JWT không hợp lệ
          run_test!
        end
      end
    end
  end
end
