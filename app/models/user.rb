# frozen_string_literal: true

class User < ApplicationRecord
  has_many :owner_cources, class_name: 'Course', foreign_key: :author_id
end
