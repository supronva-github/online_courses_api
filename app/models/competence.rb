class Competence < ApplicationRecord
  has_many :course_competences, dependent: :destroy
  has_many :courses, through: :course_competences

  validates :name, presence: true, uniqueness: true
end
