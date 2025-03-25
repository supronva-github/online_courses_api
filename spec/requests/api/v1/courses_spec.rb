# frozen_string_literal: true

require 'swagger_helper'
require 'rails_helper'

RSpec.describe 'Api::V1::Courses', type: :request do
  RSpec.shared_examples 'returns not found' do
    context 'when course is not found' do
      let(:id) { 999_999 }

      include_examples 'not_found',
                       resource_name: 'Course',
                       id: 999_999
    end
  end

  RSpec.shared_examples 'returns bad request' do
    context 'when course is missing or empty' do
      let(:course_params) { {} }

      include_examples 'bad_request'
    end
  end

  RSpec.shared_examples 'returns unprocessable entity' do
    context 'when validation fails' do
      let(:course_params) do
        {
          course: {
            title: ''
          }
        }
      end

      response '422', 'unprocessable entity' do
        schema '$ref' => '#/components/schemas/unprocessable_entity_schema'

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
          parsed_response = JSON.parse(response.body)
          expect(parsed_response['errors']['code']).to eq('unprocessable_entity')
          expect(parsed_response['errors']['message']).to include("Title can't be blank")
        end
      end
    end
  end

  RSpec.shared_examples 'returns unauthorized' do
    context 'when token invalid' do
      include_examples 'token_invalid'
    end

    context 'when token expired' do
      include_examples 'token_expired'
    end
  end

  RSpec.shared_examples 'returns forbidden' do
    context 'when there is no right to action' do
      let(:access_token) { create(:oauth_access_token) }
      let(:Authorization) { "Bearer #{access_token.token}" }

      include_examples 'forbidden'
    end
  end

  describe 'GET #index' do
    path '/api/v1/courses' do
      get 'list courses' do
        tags 'Courses API'
        produces 'application/json'
        response '200', 'courses' do
          schema '$ref' => '#/components/schemas/course_schema'

          run_test!
        end
      end
    end
  end

  describe 'GET #show' do
    path '/api/v1/courses/{id}' do
      get 'show course' do
        tags 'Courses API'
        produces 'application/json'
        parameter name: :id, in: :path, type: :string, required: true, description: 'Course ID'

        let(:course) { create(:course) }
        let(:id) { course.id }

        response '200', 'course' do
          schema '$ref' => '#/components/schemas/course_schema'

          run_test!
        end

        include_examples 'returns not found'
      end
    end
  end

  describe 'POST #create' do
    path '/api/v1/courses' do
      post 'create course' do
        tags 'Courses API'
        produces 'application/json'
        consumes 'application/json'
        parameter name: :Authorization, in: :header, type: :string, description: 'Authorization-Token',
                  example: 'Bearer <token>', required: true
        parameter name: :course_params, in: :body, required: true, schema: {
          type: :object,
          properties: {
            course: {
              type: :object,
              properties: {
                title: { type: :string, example: 'Ruby on Rails Basics' },
                description: { type: :string, example: 'A beginner-friendly course on Ruby on Rails.' },
                author_id: { type: :integer, example: 1 },
                competence_ids: {
                  type: :array,
                  items: { type: :integer },
                  example: [1, 2],
                  description: 'Array of existing competence IDs to associate with the course'
                }
              },
              required: %w[title author_id]
            }
          }
        }

        let(:access_token) { create(:oauth_access_token, resource_owner_id: author.id) }
        let(:Authorization) { "Bearer #{access_token.token}" }
        let(:author) { create(:user) }
        let(:competence1) { create(:competence) }
        let(:competence2) { create(:competence) }
        let(:course_params) do
          {
            course: {
              title: 'Ruby on Rails Basics',
              description: 'A beginner-friendly course on Ruby on Rails.',
              author_id: author.id,
              competence_ids: [competence1.id, competence2.id]
            }
          }
        end

        response '201', 'course created' do
          schema '$ref' => '#/components/schemas/course_schema'

          run_test! do
            expect(response).to have_http_status(:created)
            parsed_response = JSON.parse(response.body)
            expect(parsed_response['data']['title']).to eq('Ruby on Rails Basics')
            expect(parsed_response['data']['author']['id']).to eq(author.id)
            expect(parsed_response['data']['competences'].map { |c| c['id'] })
              .to match_array([competence1.id, competence2.id])
          end
        end

        include_examples 'returns bad request'
        include_examples 'returns unprocessable entity'
        include_examples 'returns unauthorized'
      end
    end
  end

  describe 'PUT #update' do
    path '/api/v1/courses/{id}' do
      put 'update course' do
        tags 'Courses API'
        produces 'application/json'
        consumes 'application/json'
        parameter name: :Authorization, in: :header, type: :string, description: 'Authorization-Token',
                  example: 'Bearer <token>', required: true
        parameter name: :id, in: :path, type: :string, required: true
        parameter name: :course_params, in: :body, required: true, schema: {
          type: :object,
          properties: {
            course: {
              type: :object,
              properties: {
                title: { type: :string, example: 'New title' },
                author_id: { type: :integer, example: 1 },
                competence_ids: { type: :array, items: { type: :integer }, example: [1, 2] }
              }
            }
          }
        }

        let(:access_token) { create(:oauth_access_token, resource_owner_id: author.id) }
        let(:Authorization) { "Bearer #{access_token.token}" }
        let(:course_instance) { create(:course, author: author) }
        let(:id) { course_instance.id }
        let(:author) { create(:user) }
        let(:competence1) { create(:competence) }
        let(:competence2) { create(:competence) }

        let(:course_params) do
          {
            course: {
              title: 'Updated title',
              author_id: author.id,
              competence_ids: [competence1.id, competence2.id]
            }
          }
        end

        response '200', 'course updated' do
          schema '$ref' => '#/components/schemas/course_schema'

          run_test! do
            expect(response).to have_http_status(:ok)
            parsed_response = JSON.parse(response.body)
            expect(parsed_response['data']['title']).to eq('Updated title')
            expect(parsed_response['data']['author']['id']).to eq(author.id)
            expect(parsed_response['data']['competences'].map { |c| c['id'] })
              .to match_array([competence1.id, competence2.id])
          end
        end

        include_examples 'returns not found'
        include_examples 'returns bad request'
        include_examples 'returns unprocessable entity'
        include_examples 'returns unauthorized'
        include_examples 'returns forbidden'
      end
    end
  end

  describe 'DELETE #destroy' do
    path '/api/v1/courses/{id}' do
      delete 'delete course' do
        tags 'Courses API'
        produces 'application/json'
        parameter name: :Authorization, in: :header, type: :string, description: 'Authorization-Token',
                  example: 'Bearer <token>', required: true
        parameter name: :id, in: :path, type: :string, required: true, description: 'Course ID'

        let(:access_token) { create(:oauth_access_token, resource_owner_id: author.id) }
        let(:Authorization) { "Bearer #{access_token.token}" }
        let(:author) { create(:user) }
        let(:course) { create(:course, author: author) }
        let(:id) { course.id }

        response '204', 'course deleted' do
          run_test! do
            expect(response).to have_http_status(:no_content)
          end
        end

        include_examples 'returns not found'
        include_examples 'returns unauthorized'
        include_examples 'returns forbidden'
      end
    end
  end
end
