# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CourseReassignmentService, type: :service do
  let(:user) { create(:user) }
  let(:service) { described_class.new(user) }

  subject { service.call }

  describe '#call' do
    context 'when user has no courses' do
      it 'returns true' do
        expect(subject).to be true
      end
    end

    context 'when user has courses' do
      let!(:course1) { create(:course, author: user) }
      let!(:course2) { create(:course, author: user) }

      it 'reassigns courses to another user' do
        subject

        expect(user.owner_cources.exists?).to be false
      end
    end
  end
end
