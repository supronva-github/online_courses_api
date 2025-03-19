# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Competence, type: :model do
  it { should have_many(:course_competences).dependent(:destroy) }
  it { should have_many :courses }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
