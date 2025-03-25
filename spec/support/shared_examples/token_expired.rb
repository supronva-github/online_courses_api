# frozen_string_literal: true

RSpec.shared_examples 'token_expired' do |_params|
  let(:access_token) { create(:oauth_access_token, :expired, resource_owner_id: author.id) }
  let(:Authorization) { "Bearer #{access_token.token}" }

  response '401', 'unauthorized' do
    schema '$ref' => '#/components/schemas/unauthorized_schema'

    run_test! do
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to eq({
                                                'errors' => {
                                                  'code' => 'unauthorized',
                                                  'message' => 'The access token expired'
                                                }
                                              })
    end
  end
end
