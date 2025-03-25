# frozen_string_literal: true

RSpec.shared_examples 'token_invalid' do |_params|
  let(:Authorization) { '' }

  response '401', 'unauthorized' do
    schema '$ref' => '#/components/schemas/unauthorized_schema'

    run_test! do
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to eq({
                                                'errors' => {
                                                  'code' => 'unauthorized',
                                                  'message' => 'The access token is invalid'
                                                }
                                              })
    end
  end
end
