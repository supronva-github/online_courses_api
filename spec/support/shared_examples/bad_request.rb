RSpec.shared_examples "bad_request" do
  response "400", "bad request" do
    schema Swagger::Schemas::ErrorSchema.schema("bad_request")

    run_test! do

      expect(response).to have_http_status(:bad_request)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body["errors"]["code"]).to eq("bad_request")
      expect(parsed_body["errors"]["message"]).to include("Missing or empty parameter")
    end
  end
end
