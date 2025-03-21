# frozen_string_literal: true

{
  type: :object,
  properties: {
    data: {
      oneOf: [
        { type: :array, items: { '$ref' => '#/components/schemas/competence_item_schema' } },
        { '$ref' => '#/components/schemas/competence_item_schema' }
      ]
    }
  },
  required: %w[data]
}
