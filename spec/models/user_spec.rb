require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:owner_cources).class_name('Course').with_foreign_key(:author_id) }
end
