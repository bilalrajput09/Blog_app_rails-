require 'swagger_helper'

RSpec.describe 'api/v1/posts', type: :request do

  path '/api/v1/users/{user_id}/posts' do
    # You'll want to customize the parameter types...
    parameter name: 'user_id', in: :path, type: :string, description: 'user_id'

    get('list posts') do
      response(200, 'successful') do
        let(:user_id) { '123' }

        consumes 'application/json'
        parameter name: :car, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            model: { type: :string }
          },
          required: %w[name model]
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
