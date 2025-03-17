require 'swagger_helper'
require 'rails_helper'

RSpec.describe "Api::V1::Competences", type: :request do
  describe "GET #index" do
    path "/api/v1/competences" do
      get "list competences" do
        produces "application/json"
        response '200', 'competences' do
          include_examples "competences_index_schema"

          run_test!
        end
      end
    end
  end

  describe "GET #show" do
    path "/api/v1/competences/{id}" do
      get "show competence" do
        produces "application/json"
        parameter name: :id, in: :path, type: :string, required: true, description: "Competence ID"

        let(:competence) { create(:competence) }
        let(:id) { competence.id }

        response '200', 'competences' do
          include_examples "competence_show_schema"

          run_test!
        end
      end
    end
  end

  describe "POST #create" do
    path "/api/v1/competences" do
      post "create competence" do
        produces "application/json"
        consumes "application/json"
        parameter name: :competence, in: :body, required: true, schema: {
          type: :object,
          properties: {
            competence: {
              type: :object,
              properties: {
                name: { type: :string, description: "Competence name" }
              },
              required: ["name"]
            }
          },
          required: ["competence"]
        }

          let(:competence) { { name: "New Competence" } }

          response '201', 'competence created' do
            include_examples "competence_show_schema"

            run_test! do
              expect(response).to have_http_status(:created)
            end
          end
      end
    end
  end

  describe "PUT #update" do
    path "/api/v1/competences/{id}" do
      put "update competence" do
        produces "application/json"
        consumes "application/json"
        parameter name: :id, in: :path, type: :string, required: true, description: "Competence ID"
        parameter name: :competence, in: :body, required: true, schema: {
          type: :object,
          properties: {
            competence: {
              type: :object,
              properties: {
                name: { type: :string, description: "Competence name" }
              },
              required: ["name"]
            }
          },
          required: ["competence"]
        }

        let(:competence_instance) { create(:competence) }
        let(:id) { competence_instance.id }
        let(:competence) { { name: "Updated Competence" } }

        response '200', 'competence updated' do
          include_examples "competence_show_schema"

          run_test! do
            expect(response).to have_http_status(:ok)
            expect(JSON.parse(response.body)["data"]["name"]).to eq("Updated Competence")
          end
        end
      end
    end
  end

  describe "DELETE #destroy" do
    path "/api/v1/competences/{id}" do
      delete "delete competence" do
        produces "application/json"
        parameter name: :id, in: :path, type: :string, required: true, description: "Competence ID"

        let(:competence) { create(:competence) }
        let(:id) { competence.id }

        response '204', 'competence deleted' do
          run_test! do
            expect(response).to have_http_status(:no_content)
          end
        end
      end
    end
  end
end
