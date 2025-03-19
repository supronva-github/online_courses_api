# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
module Swagger
  module Schemas
    class CourseSchema
      def self.schema
        {
          type: :object,
          properties: {
            data: {
              oneOf: [
                { type: :array, items: item_schema },
                item_schema
              ]
            }
          },
          required: %w[data]
        }
      end

      def self.item_schema
        {
          type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string },
            author: {
              type: :object,
              properties: {
                id: { type: :integer },
                name: { type: :string }
              },
              required: %w[id name]
            },
            competences: {
              type: :array,
              items: competence_schema
            }
          },
          required: %w[id title author competences]
        }
      end

      def self.competence_schema
        {
          type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string }
          },
          required: %w[id name]
        }
      end
    end
  end
end
# rubocop:enable Metrics/MethodLength
