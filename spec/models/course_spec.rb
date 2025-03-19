# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course, type: :model do
  it { should have_many :course_competences }
  it { should have_many :competences }
  it { should belong_to(:author).class_name('User').with_foreign_key(:author_id) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:author) }
end
