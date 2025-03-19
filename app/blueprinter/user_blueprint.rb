# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  identifier :id

  field :name do |user|
    "#{user.first_name} #{user.last_name}"
  end
end
