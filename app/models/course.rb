class Course < ApplicationRecord
  has_many :course_competences , dependent: :destroy
  has_many :competences, through: :course_competences
  belongs_to :author, class_name: 'User', foreign_key: :author_id

  validates :title, :author, presence: true
end
