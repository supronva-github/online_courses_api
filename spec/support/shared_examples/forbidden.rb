# frozen_string_literal: true

RSpec.shared_examples 'forbidden' do
  response '403', 'forbidden' do
    schema '$ref' => '#/components/schemas/forbidden_schema'

    run_test! do
      expect(response).to have_http_status(:forbidden)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['errors']['code']).to eq('forbidden')
      expect(parsed_body['errors']['message']).to include('You are not authorized to perform this action')
    end
  end
end
