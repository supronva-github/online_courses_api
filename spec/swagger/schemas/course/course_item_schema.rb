# frozen_string_literal: true

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
      items: { '$ref' => '#/components/schemas/competence_item_schema' }
    }
  },
  required: %w[id title author competences]
}
