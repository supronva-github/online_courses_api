require "swagger_helper"
require "rails_helper"

RSpec.describe "Api::V1::Competences", type: :request do

  RSpec.shared_examples "returns not found" do
    context "when competence is not found" do
      let(:id) { 999_999 }

      include_examples "not_found",
        resource_name: "Competence",
        id: 999_999
    end
  end

  RSpec.shared_examples "returns bad request" do
    context "when competence is missing or empty" do
      let(:competence_params) { {} }

      include_examples "bad_request"
    end
  end

  RSpec.shared_examples "returns unprocessable entity" do
    context "when validation fails" do
      let(:existing_competence) { create(:competence, name: "Existing Competence") }
      let(:competence_params) { { name: existing_competence.name } }

      response "422", "unprocessable entity" do
        schema Swagger::Schemas::ErrorSchema.schema("unprocessable_entity")

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
          parsed_response = JSON.parse(response.body)
          expect(parsed_response["errors"]["code"]).to eq("unprocessable_entity")
          expect(parsed_response["errors"]["message"]).to eq("Name has already been taken")
        end
      end
    end
  end

  describe "GET #index" do
    path "/api/v1/competences" do
      get "list competences" do
        tags "Competence API"
        produces "application/json"
        response "200", "competences" do
          schema Swagger::Schemas::CompetenceSchema.schema

          run_test!
        end
      end
    end
  end

  describe "GET #show" do
    path "/api/v1/competences/{id}" do
      get "show competence" do
        tags "Competence API"
        produces "application/json"
        parameter name: :id, in: :path, type: :string, required: true, description: "Competence ID"

        let(:competence) { create(:competence) }
        let(:id) { competence.id }

        response "200", "competences" do
          schema Swagger::Schemas::CompetenceSchema.schema

          run_test!
        end

        include_examples "returns not found"
      end
    end
  end

  describe "POST #create" do
    path "/api/v1/competences" do
      post "create competence" do
        tags "Competence API"
        produces "application/json"
        consumes "application/json"
        parameter name: :competence_params, in: :body, required: true, schema: {
          type: :object,
          properties: {
            competence: {
              type: :object,
              properties: {
                name: { type: :string, example: "Competence name" }
              },
              required: ["name"]
            }
          },
          required: ["competence"]
        }

          let(:competence_params) { { name: "New Competence" } }

          response "201", "competence created" do
            schema Swagger::Schemas::CompetenceSchema.schema

            run_test! do
              expect(response).to have_http_status(:created)
            end
          end

          include_examples "returns bad request"
          include_examples "returns unprocessable entity"
      end
    end
  end

  describe "PUT #update" do
    path "/api/v1/competences/{id}" do
      put "update competence" do
        tags "Competence API"
        produces "application/json"
        consumes "application/json"
        parameter name: :id, in: :path, type: :string, required: true, description: "Competence ID"
        parameter name: :competence_params, in: :body, required: true, schema: {
          type: :object,
          properties: {
            competence: {
              type: :object,
              properties: {
                name: { type: :string, example: "Competence name" }
              },
              required: ["name"]
            }
          },
          required: ["competence"]
        }

        let(:competence_instance) { create(:competence) }
        let(:id) { competence_instance.id }
        let(:competence_params) { { name: "Updated Competence" } }

        response "200", "competence updated" do
          schema Swagger::Schemas::CompetenceSchema.schema

          run_test! do
            expect(response).to have_http_status(:ok)
            expect(JSON.parse(response.body)["data"]["name"]).to eq("Updated Competence")
          end
        end

        include_examples "returns not found"
        include_examples "returns bad request"
        include_examples "returns unprocessable entity"
      end
    end
  end

  describe "DELETE #destroy" do
    path "/api/v1/competences/{id}" do
      delete "delete competence" do
        tags "Competence API"
        produces "application/json"
        parameter name: :id, in: :path, type: :string, required: true, description: "Competence ID"

        let(:competence) { create(:competence) }
        let(:id) { competence.id }

        response "204", "competence deleted" do
          run_test! do
            expect(response).to have_http_status(:no_content)
          end
        end

        include_examples "returns not found"
      end
    end
  end
end
