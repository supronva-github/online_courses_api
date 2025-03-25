# frozen_string_literal: true

{
  type: :object,
  properties: {
    errors: {
      type: :object,
      properties: {
        code: { type: :string, enum: ['unauthorized'] },
        message: { type: :string }
      },
      required: %w[code message]
    }
  },
  required: %w[errors]
}
