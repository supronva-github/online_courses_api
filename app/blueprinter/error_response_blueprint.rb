# frozen_string_literal: true

class ErrorResponseBlueprint < Blueprinter::Base
  fields :code, :message
end
