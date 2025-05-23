# frozen_string_literal: true

RSpec.shared_examples 'not_found' do |params|
  let(:resource_name) { params[:resource_name] }
  let(:id) { params[:id] }

  response '404', 'not found' do
    schema '$ref' => '#/components/schemas/not_found_schema'

    run_test! do
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to eq({
                                                'errors' => {
                                                  'code' => 'not_found',
                                                  'message' => "Couldn't find #{resource_name} with 'id'=#{id}"
                                                }
                                              })
    end
  end
end
