module Swagger
  module Schemas
    class CompetenceSchema
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
            name: { type: :string }
          },
          required: %w[id name]
        }
      end
    end
  end
end
