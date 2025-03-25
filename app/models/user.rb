# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :owner_courses, class_name: 'Course', foreign_key: :author_id
  has_many :access_grants,
           class_name: 'Doorkeeper::AccessGrant',
           foreign_key: :resource_owner_id,
           dependent: :destroy

  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :destroy

  def author_of?(obj)
    id == obj.author_id
  end
end
