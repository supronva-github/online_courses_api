require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  RSpec.shared_examples "returns not found" do
    context "when user is not found" do
      let(:id) { 999_999 }

      include_examples "not_found",
        resource_name: "User",
        id: 999_999
    end
  end

  describe "DELETE #destroy" do
    path "/api/v1/users/{id}" do
      delete "delete user" do
        tags "Users API"
        produces "application/json"
        parameter name: :id, in: :path, type: :string, required: true, description: "User ID"

        let(:user) { create(:user) }
        let(:id) { user.id }

        response "204", "user deleted" do
          run_test! do
            expect(response).to have_http_status(:no_content)
          end
        end

        include_examples "returns not found"
      end
    end
  end
end
