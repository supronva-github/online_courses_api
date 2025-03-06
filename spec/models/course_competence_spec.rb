require 'rails_helper'

RSpec.describe CourseCompetence, type: :model do
  it { should belong_to :course }
  it { should belong_to :competence }
end
