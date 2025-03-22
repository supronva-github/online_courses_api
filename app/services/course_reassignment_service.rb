# frozen_string_literal: true

class CourseReassignmentService
  def initialize(user)
    @user = user
  end

  def call
    ApplicationRecord.transaction do
      reassign_courses_to_random_user if user_has_courses?
      @user.destroy
      true
    end
  rescue StandardError
    false
  end

  private

  def user_has_courses?
    @user.owner_courses.any?
  end

  def reassign_courses_to_random_user
    @user.owner_courses.update_all(author_id: random_user_id)
  end

  def random_user_id
    User.where.not(id: @user.id).pluck(:id).sample
  end
end
