module Swagger
  module Schemas
    class ErrorSchema
      def self.schema(type)
        {
          type: :object,
          properties: {
            errors: {
              type: :object,
              properties: {
                code: { type: :string, enum: [type] },
                message: { type: :string }
              },
              required: %w[code message]
            }
          },
          required: %w[errors]
        }
      end
    end
  end
end
